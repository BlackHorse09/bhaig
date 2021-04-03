import 'dart:convert';
import 'package:bhaig/OrderConfimation/confirm_order.dart';
import 'package:bhaig/Utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:bhaig/Utils/connection_helper.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceOrder extends StatefulWidget {

  final Function() notifyParent;

  PlaceOrder({Key key, this.notifyParent}) : super(key : key);

  @override
  _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {

  AAAppSingleton aap;
  ConnectionHelper mCH;

  TextEditingController name;
  TextEditingController address;
  TextEditingController phone;
  TextEditingController pincode;

  bool status;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  var obj = {"status":200,"data":{"Cart":[{"img":"","VegName":"Yellow Kela Wafer 150 gm","Quantity":"2","Weight":"Piece","TotalPrice":200,"Category":"Namkeen","Cost":100,"Stock":98,"ProductId":"n3","Display":true}],"Name":"Chinmay","PhoneNumber":"9876543652","Address":"ABCD farms rose vila.","PinCode":"400062","TotalPrice":200,"Delivery":0,"DateTime":"Sun 23 Aug, 17:02:36","OrderStatus":0,"_id":36,"__v":0}};

  @override
  void initState() {
    aap = AAAppSingleton();
    mCH = ConnectionHelper.getInstance();
    name = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    pincode = TextEditingController();
    getSaveData();

    status = false;
    super.initState();
  }

  getSaveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name.text = prefs.getString("name");
    address.text = prefs.getString("address");
    phone.text = prefs.getString("phone");
    pincode.text = prefs.getString("pincode");
  }

  @override
  void dispose() {
    name.dispose();
    address.dispose();
    phone.dispose();
    pincode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: yellow,
          title: Transform(
              transform:  Matrix4.translationValues(-(h*0.070), 0.0, 0.0),
              child: Text("Order Summary",style: TextStyle(color: grey, fontWeight: FontWeight.w500,  fontSize: 22),)),
          leading: Container(),
        ),
        body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: <Widget>[
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    width: w,
                    child: ExpansionTile(
                      initiallyExpanded: true,
                      title: Text("Your Items", style: TextStyle(fontSize: 18.0, color: grey),),
                      children: aap.addCartObj.map((obj){
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                height: 60.0,
                                width: w * 0.20,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: obj['img'],
                                  placeholder: (context, url) => obj['Category'].toString().toLowerCase().contains("namkeen") ? Image.asset('assets/namkeenstatic.jpg', fit: BoxFit.cover) : Image.asset('assets/staticproduct.jpg', fit: BoxFit.cover),
                                  errorWidget: (context, url, error) => obj['Category'].toString().toLowerCase().contains("namkeen") ? Image.asset('assets/namkeenstatic.jpg', fit: BoxFit.cover) : Image.asset('assets/staticproduct.jpg', fit: BoxFit.cover),

                                ),
                              ),
                              Container(
                                height: 60.0,
                                width: w * 0.40,
                                alignment: Alignment.centerLeft,
                                // padding: EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Text("${obj['VegName']}", style: TextStyle(fontSize: 18, fontFamily: 'Schyler'), textAlign: TextAlign.start),
                              ),
                              Container(
                                height: 60.0,
                                width: w * 0.15,
                                child: Center(child: Text("₹ ${obj['TotalPrice']}", style: TextStyle(fontSize: 18, fontFamily: 'Schyler'), )),
                              ),
                              Container(
                                height: 60.0,
                                width: w * 0.15,
                                child: IconButton(
                                  onPressed: (){
                                    aap.totalCartAmount = aap.totalCartAmount - obj['TotalPrice'];
                                    aap.addCartObj.remove(obj);
                                    if(aap.addCartObj.length == 0 || aap.addCartObj == []) {
                                      widget.notifyParent();
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(FontAwesomeIcons.solidTrashAlt, size: 20, ),),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sub-total", style: TextStyle(fontSize: 18.0, fontFamily: 'Schyler'),),
                        Text("₹ ${aap.totalCartAmount.ceil()}",style: TextStyle(fontSize: 18.0, fontFamily: 'Schyler'),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery charges", style: TextStyle(fontSize: 18.0, fontFamily: 'Schyler'),),
                        Text("₹ ${aap.deliveryCharges}",style: TextStyle(fontSize: 18.0, fontFamily: 'Schyler'),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total", style: TextStyle(fontSize: 26.0, fontFamily: 'Schyler'),),
                        Text("₹ ${aap.totalCartAmount.ceil() + aap.deliveryCharges}",style: TextStyle(fontSize: 26.0, fontFamily: 'Schyler'),),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: lightGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                      ),
                      elevation: 3.0,
                      child: LayoutBuilder(
                        builder: (context, size){
                          return Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Change Delivery Details", style: TextStyle(fontSize: 22, fontFamily: 'Schyler'),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Switch(
                                      activeColor: yellow,
                                      value: status,
                                      onChanged: (value) {

                                        FocusScopeNode currentFocus = FocusScope.of(context);

                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }

                                        print("VALUE : $value");
                                        setState(() {
                                          status = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 25,
                                      child: Container(
                                          child: Text("Name")
                                      ),
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
                                              controller: name,
                                              readOnly:  !status,
                                              style: TextStyle(height: 1.0),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(fontSize: 14),
                                                  isDense: true,
                                                  contentPadding: EdgeInsets.only(top: 4.0)
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
                                padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 25,
                                      child: Container(
                                          child: Text("Phone No.")
                                      ),
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
                                              controller: phone,
                                              readOnly:  !status,
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(height: 1.0),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.only(top: 4.0)
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
                                padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 25,
                                      child: Container(
                                          child: Text("Address")
                                      ),
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
                                            readOnly:  !status,
                                            style: TextStyle(height: 1.1),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.only(left: 8.0, top: 4.0)
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
                                padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 25,
                                      child: Container(
                                          child: Text("Pincode")
                                      ),
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
                                              readOnly:  !status,
                                              maxLines: null,
                                              keyboardType: TextInputType.number,
                                              style: TextStyle(height: 1.0),
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.only(top: 4.0)
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8.0,),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
//                    Container(
//                      padding: EdgeInsets.all(8.0),
//                      child: Card(
//                        elevation: 3,
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[

//                            SizedBox(
//                              height: 8.0,
//                            ),
//                            Container(
//                              padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
//                              child: Row(
//                                children: <Widget>[
//                                  Expanded(
//                                    flex: 25,
//                                    child: Container(
//                                        child: Text("Name")
//                                    ),
//                                  ),
//                                  Expanded(
//                                    flex: 75,
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        borderRadius: BorderRadius.circular(4.0),
//
//                                      ),
//                                      child: SizedBox(
//                                        height: 25,
//                                        child: Padding(
//                                          padding: const EdgeInsets.only(left: 8.0),
//                                          child: TextField(
//                                            controller: name,
//                                            style: TextStyle(height: 1.0),
//                                            decoration: InputDecoration(
//                                                border: InputBorder.none,
//
//                                                hintStyle: TextStyle(fontSize: 14)
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            Container(
//                              padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
//                              child: Row(
//                                children: <Widget>[
//                                  Expanded(
//                                    flex: 25,
//                                    child: Container(
//                                        child: Text("Address")
//                                    ),
//                                  ),
//                                  Expanded(
//                                    flex: 75,
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        borderRadius: BorderRadius.circular(4.0),
//                                      ),
//                                      child: SizedBox(
//                                        height: 25,
//                                        child: TextField(
//                                          maxLines: null,
//                                          controller: address,
//                                          style: TextStyle(height: 1.1),
//                                          decoration: InputDecoration(
//                                              border: InputBorder.none,
//                                              isDense: true,
//                                              contentPadding: EdgeInsets.only(left: 8.0, top: 4.0)
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            Container(
//                              padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
//                              child: Row(
//                                children: <Widget>[
//                                  Expanded(
//                                    flex: 25,
//                                    child: Container(
//                                        child: Text("Phone No.")
//                                    ),
//                                  ),
//                                  Expanded(
//                                    flex: 75,
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        borderRadius: BorderRadius.circular(4.0),
//
//                                      ),
//                                      child: SizedBox(
//                                        height: 25,
//                                        child: Padding(
//                                          padding: const EdgeInsets.only(left: 8.0),
//                                          child: TextField(
//                                            controller: phone,
//                                            keyboardType: TextInputType.number,
//                                            style: TextStyle(height: 1.0),
//                                            decoration: InputDecoration(
//                                              border: InputBorder.none,
//
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            Container(
//                              padding: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8.0),
//                              child: Row(
//                                children: <Widget>[
//                                  Expanded(
//                                    flex: 25,
//                                    child: Container(
//                                        child: Text("Pincode")
//                                    ),
//                                  ),
//                                  Expanded(
//                                    flex: 75,
//                                    child: Container(
//                                      decoration: BoxDecoration(
//                                        color: Colors.white,
//                                        borderRadius: BorderRadius.circular(4.0),
//
//                                      ),
//                                      child: SizedBox(
//                                        height: 25,
//                                        child: Padding(
//                                          padding: const EdgeInsets.only(left: 8.0),
//                                          child: TextField(
//                                            controller: pincode,
//                                            keyboardType: TextInputType.number,
//                                            style: TextStyle(height: 1.0),
//                                            decoration: InputDecoration(
//                                              border: InputBorder.none,
//                                            ),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            SizedBox(height: 8.0,),
//
//                          ],
//                        ),
//                      ),
//                    ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)
                        ),
                        onPressed: () async {
                          if(checkError()) {
                            bool con = await mCH.checkConnection();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            if (con) {
                              DateTime now = DateTime.now();
                              String formatedDate = DateFormat('EEE d MMM, kk:mm:ss').format(now);

                              _showLoading();

                              var req = json.encode({
                                "Name": "${name.text}",
                                "PhoneNumber": "${phone.text}",
                                "Address": "${address.text}",
                                "PinCode": "${pincode.text}",
                                "TotalPrice": aap.totalCartAmount,
                                "Delivery": 0.0,
                                "DateTime": "$formatedDate",
                                "Cart": aap.addCartObj,
                                "OrderStatus" : 0,
                              });

                              print(req);

                              final HEADERS = {
                                "Content-type" : "application/json",
                                "Accept": "application/json"
                              };

                              final res = await http.post("${BASEURL}addToCart", headers: HEADERS, body: req);

                              if(res.statusCode == 200) {

                                var obj = json.decode(res.body);
                                aap.billId = obj['data']['_id'];

                                Navigator.of(context).pop();

                                prefs.setString("name", name.text);
                                prefs.setString("address", address.text);
                                prefs.setString("phone", phone.text);
                                prefs.setString("pincode", pincode.text);

                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    settings: RouteSettings(name: '/order_confirmation'),
                                    pageBuilder: (c, a1, a2) => OrderConfirmation(),
                                    transitionsBuilder: (c, anim, a2, child) =>
                                        FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 500),
                                  ),
                                );

//                                Navigator.popUntil(context, ModalRoute.withName('/list_of_items'));
                              } else {
                                Navigator.of(context).pop();
                                _showMessage("Something went wrong please try again later");
                              }

                            } else {
                              _showMessage("Please check your Internet Connection");
                            }
                          }
                        },
                        child: Text("Place Order", style: TextStyle(fontSize: 24, fontFamily: 'Schyler'),),
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  bool checkError() {
    int count = 0;
    if(aap.addCartObj.length == 0 || aap.addCartObj == []) {
      _showMessage("Your Cart cannot be empty");
      return false;
    } else if(aap.totalCartAmount < aap.minimumCost) {
      _showMessage("Your cart amount must be greater than ${aap.minimumCost}");
      return false;
    } else if(name.text == "") {
      _showMessage("Please enter Name");
      return false;
    } else if(address.text == "") {
      _showMessage("Please enter Address");
      return false;
    } else if(phone.text == "") {
      _showMessage("Please enter Phone Number");
      return false;
    } else if(phone.text.length != 10) {
      _showMessage("Please enter 10 digit phone number");
      return false;
    } else if(pincode.text == "") {
      _showMessage("Please enter Pincode");
      return false;
    } else if(aap.pincodeList != []) {
      for(int i=0; i < aap.pincodeList.length; i++) {
        if(pincode.text == aap.pincodeList[i].trim()) {
          count++;
        }
      }

      if(count == 0) {
        _showMessage("Sorry. We don't deliver at the given pincode. We deliver at ${aap.pincodeList}");
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(
        duration: Duration(milliseconds: 2500),
        content: Text(message, style: TextStyle(fontSize: 16),));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _showLoading() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            //contentPadding: const EdgeInsets.only(left : 16, right: 0, top: 10, bottom: 10),
            content: Container(
              width: 200,
              child: Row(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  Text('Loading...'),
                ],
              ),
            ),
          );
        }); //end showDialog()
  }
}
