import 'package:bhaig/HomePage/home_ui_change.dart';
import 'package:bhaig/OrderConfimation/confirm_order.dart';
import 'package:bhaig/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController username;
  TextEditingController phonenumber;
  TextEditingController pincode;
  TextEditingController address;

  double h, w;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    username = new TextEditingController();
    phonenumber = new TextEditingController();
    pincode = new TextEditingController();
    address = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    username.dispose();
    phonenumber.dispose();
    pincode.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    print(h);

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: h * 0.104,
            ),
            Container(
              height: h * 0.25,
              width: w,
              child: Center(
                child: Image.asset(
                  'assets/logofinal.png',
                ),
              ),
            ),
            SizedBox(
              height: h * 0.07,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: lightGrey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 3.0,
                child: LayoutBuilder(
                  builder: (context, size) {
                    return Column(
                      children: <Widget>[
                        Container(
                          width: size.maxWidth,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              "Delivery Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 8, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 25,
                                child: Container(child: Text("Name")),
                              ),
                              Expanded(
                                flex: 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SizedBox(
                                    height: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: username,
                                        style: TextStyle(height: 1.0),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 8, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 25,
                                child: Container(child: Text("Phone No.")),
                              ),
                              Expanded(
                                flex: 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SizedBox(
                                    height: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: phonenumber,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(height: 1.0),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 8, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 25,
                                child: Container(child: Text("Address")),
                              ),
                              Expanded(
                                flex: 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SizedBox(
                                    height: 25,
                                    child: TextField(
                                      maxLines: null,
                                      controller: address,
                                      style: TextStyle(height: 1.1),
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.only(
                                              left: 8.0, top: 4.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 18, right: 18, top: 8, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 25,
                                child: Container(child: Text("Pincode")),
                              ),
                              Expanded(
                                flex: 75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: SizedBox(
                                    height: 25,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: TextField(
                                        controller: pincode,
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(height: 1.0),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              height: 55.0,
              padding: EdgeInsets.symmetric(horizontal: 32.0),
              child: RaisedButton(
                color: yellow,
                onPressed: () async {
                  if (checkError()) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString("name", username.text);
                    prefs.setString("address", address.text);
                    prefs.setString("phone", phonenumber.text);
                    prefs.setString("pincode", pincode.text);

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
                  }
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_forward,
                        color: grey,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        "GET STARTED",
                        style: TextStyle(
                            fontSize: 18,
                            color: grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool checkError() {
    if (username.text == "") {
      _showMessage("Please enter Name");
      return false;
    } else if (address.text == "") {
      _showMessage("Please enter Address");
      return false;
    } else if (phonenumber.text == "") {
      _showMessage("Please enter Phone Number");
      return false;
    } else if (phonenumber.text.length != 10) {
      _showMessage("Please enter 10 digit phone number and remove +91 if added");
      return false;
    } else if (pincode.text == "") {
      _showMessage("Please enter Pincode");
      return false;
    } else {
      return true;
    }
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(
        content: Text(
      message,
      style: TextStyle(fontSize: 12),
    ));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
