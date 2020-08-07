import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bhaig/Utils/connection_helper.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    aap = AAAppSingleton();
    mCH = ConnectionHelper.getInstance();
    name = TextEditingController();
    address = TextEditingController();
    phone = TextEditingController();
    pincode = TextEditingController();

    name.text = "Test User";
    address.text = "abc Farms";
    phone.text = "4445556660";
    pincode.text = "000000";

    status = false;
    super.initState();
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

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cart"),
        leading: Icon(Icons.shopping_cart),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Card(
                    child: Container(
                      width: w,
                      child: ExpansionTile(
                        title: Text("TOTAL", style: TextStyle(fontSize: 22.0),),
                        children: aap.addCartObj.map((obj){
                          return Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: 60.0,
                                    width: w * 0.20,
                                    child: Image.asset("assets/demo.jpeg", fit: BoxFit.cover,),
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: w * 0.40,
                                    // padding: EdgeInsets.only(left: 8.0, top: 8.0),
                                    child: Center(child: Text("${obj['VegName']}", style: TextStyle(fontSize: 18), textAlign: TextAlign.start,)),
                                  ),
                                  Container(
                                    height: 60.0,
                                    width: w * 0.15,
                                    child: IconButton(icon: Icon(Icons.edit, size: 30,),
                                      onPressed: (){

                                      },
                                    ),
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
                                      icon: Icon(Icons.delete, size: 30,),),
                                  ),
                                ],
                              ),
//                      ListTile(
//                        title: Text(obj['Name']),
//                        trailing: Text("350"),
//                        leading: CachedNetworkImage(
//                          imageUrl: '${obj['ListImage']}',
//                          placeholder: (context, url) => CircularProgressIndicator(),
//                          errorWidget: (context, url, error) => Icon(Icons.error),
//                        ),
//                      ),
                              SizedBox(height: 16.0,)
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Sub-total", style: TextStyle(fontSize: 18.0),),
                        Text("${aap.totalCartAmount}",style: TextStyle(fontSize: 18.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Delivery charges", style: TextStyle(fontSize: 18.0),),
                        Text("Free",style: TextStyle(fontSize: 18.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Total", style: TextStyle(fontSize: 26.0),),
                        Text("${aap.totalCartAmount}",style: TextStyle(fontSize: 26.0),),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0,),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Change Delivery Details", style: TextStyle(fontSize: 22),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Switch(
                                  activeColor: Colors.yellowAccent,
                                  value: status,
                                  onChanged: (value) {
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
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Name", style: TextStyle(fontSize: 21)),
                                ),
                              ),
                              Expanded(
                                flex: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: name,
                                      readOnly: !status,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Address", style: TextStyle(fontSize: 21))
                                ),
                              ),
                              Expanded(
                                flex: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: address,
                                      readOnly: !status,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Phone Number", style: TextStyle(fontSize: 21))
                                ),
                              ),
                              Expanded(
                                flex: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: TextField(
                                      controller: phone,
                                      readOnly: !status,
                                      maxLines: null,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(8.0),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 30,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("PinCode", style: TextStyle(fontSize: 21),)
                                ),
                              ),
                              Expanded(
                                flex: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    child: TextField(
                                      readOnly: !status,
                                      controller: pincode,
                                      maxLines: null,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(8.0),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8.0,),

                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        onPressed: () async {
                          if(checkError()) {
                            bool con = await mCH.checkConnection();

                            if (con) {
                              DateTime now = DateTime.now();
                              String formatedDate = DateFormat('EEE d MMM, kk:mm:ss')
                                  .format(now);

                              var req = json.encode({
                                "Name": "${name.text}",
                                "PhoneNUmber": "${phone.text}",
                                "Address": "${address.text}",
                                "PinCode": "${pincode.text}",
                                "TotalPrice": aap.totalCartAmount,
                                "Delivery": 0.0,
                                "DateTime": "$formatedDate",
                                "Cart": aap.addCartObj
                              });

                              print(req);

                              final HEADERS = {
                                "Content-type" : "application/json",
                                "Accept": "application/json"
                              };

                              final res = await http.post("https://trial-demo-app-heroku.herokuapp.com/addToCart", headers: HEADERS, body: req);

                              if(res.statusCode == 200) {
                                _showMessage("Done. Your order will be there soon");
                                aap.addCartObj = [];
                                aap.totalCartAmount = 0.0;
                                aap.enablePayment = false;
                                Navigator.popUntil(context, ModalRoute.withName('/list_of_items'));
                              }

                            } else {
                              _showMessage("Please check your Internet Connection");
                            }
                          }
                        },
                        child: Text("Place Order", style: TextStyle(fontSize: 24),),
                      ),
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  bool checkError() {
    if(aap.addCartObj.length == 0 || aap.addCartObj == []) {
      _showMessage("Your Cart cannot be empty");
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
    } else {
      return true;
    }
  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message, style: TextStyle(fontSize: 12),));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
