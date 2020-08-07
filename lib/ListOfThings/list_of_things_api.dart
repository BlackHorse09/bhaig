import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bhaig/Utils/app_models.dart';
import 'package:bhaig/Utils/connection_helper.dart';

class GetListAPI {
  ConnectionHelper mCH;

  GetListAPI(){
    mCH = ConnectionHelper.getInstance();
  }


  Future<CategrotyModel> GetListItemsFromAPI() async {

    CategrotyModel res_d;

    bool con = await mCH.checkConnection();
    if (con) {
      try {

        final HEADERS = {
          "Content-type" : "application/json",
          "Accept": "application/json"
        };

        final res = await http.get("https://trial-demo-app-heroku.herokuapp.com/getVegetables", headers: HEADERS);

        switch (res.statusCode) {
          case 200:
            final j_data = json.decode(res.body);
            print('Res ---> ${res.body}');
            res_d = CategrotyModel.fromJson(j_data);
            print(res_d);
            return res_d;
          default:
            return res_d;
        }
      } catch (err) {
        return res_d;
        //return CategrotyModel.buildErr(0,message: "Something went wrong. Please try again later.");
      }
    } else {
      return res_d;

      //return CategrotyModel.buildErr(1);
    }
  }

}