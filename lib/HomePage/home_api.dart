
import 'dart:convert';
import 'package:bhaig/Utils/connection_helper.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:http/http.dart' as http;
import 'package:bhaig/Utils/app_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeApi {

  ConnectionHelper mCH;
  AAAppSingleton aap;

  HomeApi() {
    mCH = ConnectionHelper.getInstance();
    aap = AAAppSingleton();
  }

  Future<HomePageModel> GetHomePageData() async {

    HomePageModel res_d = HomePageModel();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool con = await mCH.checkConnection();

      if(con) {
        try {
          final HEADERS = {
            "Content-type" : "application/json",
            "Accept": "application/json"
          };

          final res = await http.get("https://trial-demo-app-heroku.herokuapp.com/getHomeData", headers: HEADERS);

          switch (res.statusCode) {
            case 200:
              final j_data = json.decode(res.body);
              print('Res ---> ${res.body}');
              res_d = HomePageModel.fromJson(j_data);
              aap.pincodeList = res_d.data.PincodeList.split(",");
              aap.minimumCost = res_d.data.MinimumCost;
              aap.deliveryCharges = res_d.data.DeliveryCharges;
              aap.cmpanyName = res_d.data.EnterpriseName;

              prefs.setString("st", res_d.data.StartTime);
              if(int.parse(res_d.data.EndTime) > 12) {
                int temp = int.parse(res_d.data.EndTime) - 12;
                print("Time is :- $temp");
                res_d.data.EndTime = temp.toString();
              }
              prefs.setString("et", res_d.data.EndTime);


              print(res_d);
              return res_d;
            default:
              return HomePageModel.buildErr(res.statusCode, message: "Something went Wrong");
          }
        } catch (err) {
          return HomePageModel.buildErr(0,message: "Something went wrong. Please try again later.");
        }
      } else {
        return HomePageModel.buildErr(1, message: "Check your internet connection");
      }

      //return CategrotyModel.buildErr(1);
    }
  }



