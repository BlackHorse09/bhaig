import 'package:bhaig/ContactUs/contact_page.dart';
import 'package:bhaig/Utils/connection_helper.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'HomePage/home_ui_change.dart';
import 'package:bhaig/Utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double h,w;

  ConnectionHelper mCH;
  bool timeup = false;
  AAAppSingleton aap;

  @override
  void initState() {
    mCH = ConnectionHelper.getInstance();
    aap = AAAppSingleton();
    navigationScreen();
    super.initState();
  }

  navigationScreen() async {


    Future.delayed(Duration(seconds: 2), () async {

      String startTime, endTime;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      startTime = prefs.getString("st") ?? "08";
      endTime = prefs.getString("et") ?? "08";

      String date = DateFormat.yMEd().add_jms().format(DateTime.now());
      print(date);

      List temp = date.split(" ");
      print(temp[3].toString().toLowerCase());
      print(temp[2]);
      temp[2] = temp[2].toString().split(":").first;

      if(temp[3].toString().toLowerCase() == "am") {
        if(int.parse(startTime ?? "08") <= int.parse(temp[2]) && int.parse(temp[2]) < 12) {
          aap.isTimeUp = false;
          aap.start = startTime;
          aap.end = endTime;
          bool con = await mCH.checkConnection();
          if(con) {

            final HEADERS = {
              "Content-type" : "application/json",
              "Accept": "application/json"
            };

            var res = await http.get("${BASEURL}getVegetables", headers: HEADERS).timeout(Duration(milliseconds: 100),
                onTimeout: (){
                  return null;
                });
          }
        } else {
          aap.isTimeUp = true;
          aap.start = startTime;
          aap.end = endTime;
        }
      } else {
        if(int.parse(endTime ?? "08") > int.parse(temp[2]) || int.parse(temp[2]) == 12) {
          aap.isTimeUp = false;
          aap.start = startTime;
          aap.end = endTime;
          bool con = await mCH.checkConnection();
          if(con) {

            final HEADERS = {
              "Content-type" : "application/json",
              "Accept": "application/json"
            };

            var res = await http.get("${BASEURL}getVegetables", headers: HEADERS).timeout(Duration(milliseconds: 100),
                onTimeout: (){
                  return null;
                });
          }
        } else {
          aap.isTimeUp = true;
          aap.start = startTime;
          aap.end = endTime;
        }
      }


      if(prefs.getString('name') != null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            settings: RouteSettings(name: '/home_page'),
            pageBuilder: (c, a1, a2) => HomePageUI(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            settings: RouteSettings(name: '/contact_page'),
            pageBuilder: (c, a1, a2) => ContactPage(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      }
    });



  }

  @override
  Widget build(BuildContext context) {

    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: h,
        width: w,
        color: Colors.white,
        child: Center(
          child: Container(
              height: h/2-50,
              width: w,
              child: Image.asset("assets/logofinal.png", )),
        ),
      ),
    );
  }
}
