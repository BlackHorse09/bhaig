
import 'package:bhaig/Utils/constants.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:flutter/material.dart';

class OrderConfirmation extends StatefulWidget {
  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {

  double h,w;

  AAAppSingleton aap;
  double finalBill = 0.0;

  @override
  void initState() {
    aap = AAAppSingleton();
    finalBill = aap.totalCartAmount;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        return ResetFunction();
      },
      child: SafeArea(
        child: Scaffold(
            body: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[

                  Container(
                    height: h*0.35,
                    width: w,
                    child: Center(
                      child: Image.asset('assets/box.jpg', fit: BoxFit.cover,),
                    ),
                  ),

                  SizedBox(height: 16.0,),

                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Container(
                        color: lightGrey,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[

                            Container(
                              child: Text("${aap.cmpanyName}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                            ),

                            Divider(),

                            Container(
                              width: w,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Order# ${aap.billId}", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: yellow,
                                        child: Icon(Icons.done, color: grey,),
                                      ),
                                      SizedBox(width: 16.0,),
                                      Text("Placed", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),)
                                    ],
                                  )
                                ],
                              )
                            ),

                            Divider(),

                            SizedBox(height: 8.0,),
                            for(var item in aap.addCartObj) getWidgets(item),

                            SizedBox(height: 8.0,),
                            Container(
                                alignment: Alignment.centerLeft,
                                width: w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Delivery", style: TextStyle(fontSize: 20, fontFamily: 'Schyler'),),
                                    Text("₹ ${aap.deliveryCharges}", style: TextStyle(fontSize: 20, fontFamily: 'Schyler'),),
                                  ],
                                )),
                            SizedBox(height: 8.0,),
                            Container(
                                alignment: Alignment.centerLeft,
                                width: w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text("Total", style: TextStyle(fontSize: 24, fontFamily: 'Schyler'),),
                                    Text("₹ ${finalBill.ceil()}", style: TextStyle(fontSize: 24, fontFamily: 'Schyler'),),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0,)
                ],
              ),
            )
        ),
      ),
    );
  }

  getWidgets(item) {
    Widget m = Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  flex: 75,
                  child: Container(

                      child: Text("${item['VegName']}", style: TextStyle(fontSize: 20, fontFamily: 'Schyler'),))),
              Expanded(
                  flex: 25,
                  child: Container(

                      child: Center(child: Text("${item['Quantity']}", style: TextStyle(fontSize: 20, fontFamily: 'Schyler'),)))),
              Expanded(
                  flex: 25,
                  child: Container(
                      child: Text("₹ ${item['TotalPrice']}", textAlign: TextAlign.end,style: TextStyle(fontSize: 20, fontFamily: 'Schyler'),))),
            ],
          ),
          Divider(),
          SizedBox(height: 4.0,)
        ],
      )
    );

    return m;
  }

  ResetFunction() {
    aap.addCartObj = [];
    aap.totalCartAmount = 0.0;
    aap.enablePayment = false;
    Navigator.popUntil(context, ModalRoute.withName('/home_page'));
  }
}
