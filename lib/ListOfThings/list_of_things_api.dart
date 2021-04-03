import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bhaig/Utils/app_models.dart';
import 'package:bhaig/Utils/connection_helper.dart';
import 'package:bhaig/Utils/constants.dart';

class GetListAPI {
  ConnectionHelper mCH;

  GetListAPI(){
    mCH = ConnectionHelper.getInstance();
  }


  Future<CategrotyModel> GetListItemsFromAPI(int index, bool status) async {

    CategrotyModel res_d;

    bool con = await mCH.checkConnection();

    var res;

    if (con) {
      try {

        final HEADERS = {
          "Content-type" : "application/json",
          "Accept": "application/json"
        };

        if(index == 1) {
          res = await http.get("${BASEURL}getVegetables", headers: HEADERS);
        }
         else if(index == 2) {
          res = await http.get("${BASEURL}getFruits", headers: HEADERS);
        } else if(index == 3) {
          res = await http.get("${BASEURL}getNamkeens", headers: HEADERS);
        }

        switch (res.statusCode) {
          case 200:
            final j_data = json.decode(res.body);
            print('Res ---> ${res.body}');
            res_d = CategrotyModel.fromJson(j_data);
            print(res_d);
            res_d.ApiStatus = status;
            return res_d;
          default:
            return CategrotyModel.buildErr(res.statusCode, message: "Something went Wrong");
        }
      } catch (err) {

        return CategrotyModel.buildErr(0,message: "Something went wrong. Please try again later.");
      }
    } else {
      return CategrotyModel.buildErr(1, message: "Check your internet connection");
    }
  }

}