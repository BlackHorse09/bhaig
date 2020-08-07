import 'dart:async';

import 'package:flutter/material.dart';

import 'Utils/singleton.dart';

class AddToCartPageUi extends StatefulWidget {

  String weightIdentifier;
  String name;
  String image;
  int cost;
  int stock;
  String category;
  String p_id;
  bool display;

  AddToCartPageUi({Key key, this.category,this.display, this.p_id, this.weightIdentifier, this.name, this.cost, this.image, this.stock}) : super(key: key);

  @override
  _AddToCartPageUiState createState() => _AddToCartPageUiState();
}

class _AddToCartPageUiState extends State<AddToCartPageUi> {
  double h, w;

  int counter = 0;
  int counter1 = 0;
  int counter2 = 0;

  double totalPrice = 0.0;
  double totalWeight = 0.0;
  int totalPc = 0;
  int weightCost = 0;

  String weightIdentidier = "";

  double fruitCost = 0.0;

  int isGram = 1;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AAAppSingleton aap;

  bool once = true;
  final _controller = ScrollController();

  @override
  void initState() {
    weightIdentidier = widget.weightIdentifier;
    aap = AAAppSingleton();
    initializeData();
    super.initState();
  }


  initializeData() {
    if(weightIdentidier.contains("gm")) {
      isGram = 1;
      weightCost = widget.cost;
    } else {

      if(weightIdentidier == "1pc3pc") {
        isGram = 3;
      } else {
        isGram = 2;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    if(once) {
      Timer(
        Duration(milliseconds: 500),
            () => _controller.jumpTo(_controller.position.maxScrollExtent),
      );
      once = false;
      setState(() {});
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("The best you can get"),
        actions: <Widget>[
          Icon(Icons.shopping_cart),
        ],
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
              padding: const EdgeInsets.only(bottom: 60),
              child: ListView(
                shrinkWrap:  true,
                controller: _controller,
                physics: ScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 8.0,),
                          Container(
                            height: h*0.25,
                            color: Colors.transparent,
                            child: Image.asset("assets/demo.jpeg", fit: BoxFit.cover,),
//                          child: CachedNetworkImage(
//                            fit: BoxFit.cover,
//                            imageUrl: 'http://dexterlabs.co.in/images/portfolio/Logikart.jpg',
//                            placeholder: (context, url) => CircularProgressIndicator(),
//                            errorWidget: (context, url, error) => Icon(Icons.error),
//                          ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(8.0),
                    child: Container(

                      width: w,
                      child: Card(
                        elevation: 15.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.name, style: TextStyle(fontSize: 22),),
                        ),
                      ),
                    ),),

                  Container(
                    height: isGram == 1 ? h*0.30 : isGram == 3 ? h*0.22 : h*0.15,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: getChildren(weightIdentidier)
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12.0,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 15.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Container(
                        height: h*0.1,
                        width: w,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(isGram == 1 ? "Weight" : "Qty", style: TextStyle(color: Colors.black, fontSize: 22)),
                                  Text(isGram == 1 ? "$totalWeight" : "$totalPc", style: TextStyle(color: Colors.black, fontSize: 20)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text("Rate", style: TextStyle(color: Colors.black, fontSize: 22)),
                                  Text( isGram == 1 ? "${widget.cost}/Kg" : "${widget.cost}/Pc", style: TextStyle(color: Colors.black, fontSize: 20)),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text("Amount", style: TextStyle(color: Colors.black, fontSize: 22)),
                                  Text("$totalPrice", style: TextStyle(color: Colors.black, fontSize: 20)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0,),

                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: h*0.1,
                child: RaisedButton(
                  color: Colors.yellowAccent.shade400,
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    if(totalPrice == 0.0) {
                      _showMessage("Please select the weight you want to buy");
                    } else {
                      aap.addCartObj.add({
                        "img" : "${widget.image}",
                        "VegName" : "${widget.name}",
                        "Quantity" : isGram == 1 ? "$totalWeight" : "$totalPc",
                        "Weight" : isGram == 1 ? "Kg" : "Piece",
                        "TotalPrice" : totalPrice,
                        "Category" : widget.category,
                        "Cost" : widget.cost,
                        "Stock" : widget.stock,
                        "ProductId" : widget.p_id,
                        "Display" : widget.display,
                      });
                      aap.totalCartAmount = aap.totalCartAmount + totalPrice;
                      print(aap.addCartObj);
                      print(aap.totalCartAmount);
                      if(aap.addCartObj.length > 0) {
                        aap.enablePayment = true;
                      }
                      Navigator.pop(context, {"done" : true});
                    }
                  },
                  child: Center(
                    child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 26,)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
//      body: Column(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Container(
//            height: h*0.3,
//            width: w,
//            padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
//            child: Card(
//              elevation: 15.0,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Padding(
//                    padding: const EdgeInsets.only(top : 4.0),
//                    child: Text("Strawberries", style: TextStyle(color: Colors.black, fontSize: 26)),
//                  ),
//                  SizedBox(height: 8.0,),
//                  Container(
//                    color: Colors.transparent,
//                    child: CachedNetworkImage(
//                      fit: BoxFit.cover,
//                      imageUrl: 'http://dexterlabs.co.in/images/portfolio/Logikart.jpg',
//                      placeholder: (context, url) => CircularProgressIndicator(),
//                      errorWidget: (context, url, error) => Icon(Icons.error),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Container(
//            height: h*0.55,
//            child: Card(
//              elevation: 15,
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  SizedBox(height: 16.0,),
//                  Text("500/Kg", style: TextStyle(color: Colors.black, fontSize: 26),),
//                  SizedBox(height: 8.0,),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text("250 gm", style: TextStyle(color: Colors.black, fontSize: 22)),
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.remove, size: 26,),
//                            SizedBox(width: 16.0,),
//                            Text("0", style: TextStyle(fontSize: 22),),
//                            SizedBox(width: 16.0,),
//                            Icon(Icons.add, size: 26,),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                  SizedBox(height: 8.0,),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text("500 gm", style: TextStyle(color: Colors.black, fontSize: 22)),
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.remove, size: 26,),
//                            SizedBox(width: 16.0,),
//                            Text("0", style: TextStyle(fontSize: 22),),
//                            SizedBox(width: 16.0,),
//                            Icon(Icons.add, size: 26,),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Text("1 Kg", style: TextStyle(color: Colors.black, fontSize: 22)),
//                        Row(
//                          children: <Widget>[
//                            Icon(Icons.remove, size: 26,),
//                            SizedBox(width: 16.0,),
//                            Text("0", style: TextStyle(fontSize: 22),),
//                            SizedBox(width: 16.0,),
//                            Icon(Icons.add, size: 26,),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                  Divider(),
//                  Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Column(
//                          children: <Widget>[
//                            Text("Weight", style: TextStyle(color: Colors.black, fontSize: 22)),
//                            Text("3.5 Kg", style: TextStyle(color: Colors.black, fontSize: 20)),
//                          ],
//                        ),
//                        Column(
//                          children: <Widget>[
//                            Text("Rate", style: TextStyle(color: Colors.black, fontSize: 22)),
//                            Text("500/Kg", style: TextStyle(color: Colors.black, fontSize: 20)),
//                          ],
//                        ),
//                        Column(
//                          children: <Widget>[
//                            Text("Amount", style: TextStyle(color: Colors.black, fontSize: 22)),
//                            Text("1750", style: TextStyle(color: Colors.black, fontSize: 20)),
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
////                    Padding(
////                      padding: const EdgeInsets.all(8.0),
////                      child: Row(
////                        crossAxisAlignment: CrossAxisAlignment.center,
////                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                        children: <Widget>[
////                          Text("3.5 Kg", style: TextStyle(color: Colors.black, fontSize: 20)),
////                          Text("500/Kg", style: TextStyle(color: Colors.black, fontSize: 20)),
////                          Text("1750", style: TextStyle(color: Colors.black, fontSize: 20)),
////                        ],
////                      ),
////                    ),
//                ],
//              ),
//            ),
//          ),
//
//          Container(
//            height: h*0.1,
//            child: RaisedButton(
//              child: Center(
//                child: Text("Add to Cart", style: TextStyle(color: Colors.white, fontSize: 26,)),
//              ),
//            ),
//          )
//        ],
//      ),

    );
  }

  List<Widget> getChildren(String identifier) {

    List<Widget> mw = [];

    if(identifier.contains("gm")) {

      if (identifier.toLowerCase() == "250gm500gm1kg") {
        mw.add(Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("250 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 1;
                        totalPrice = totalPrice - (weightCost/4);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.25;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 1;
                      totalPrice = totalPrice + (weightCost/4);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.25;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

        mw.add(Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("500 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter1 > 0) {
                        counter1 = counter1 - 1;
                        totalPrice = totalPrice - (weightCost/2);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.50;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter1", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter1 = counter1 + 1;
                      totalPrice = totalPrice + (weightCost/2);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.50;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

        mw.add(Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("1 Kg",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter2 > 0) {
                        counter2 = counter2 - 1;
                        totalPrice = totalPrice - weightCost;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 1.00;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter2", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter2 = counter2 + 1;
                      totalPrice = totalPrice + weightCost;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 1.00;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

      } else if (identifier.toLowerCase() == "500gm1kg") {

        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("500 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 1;
                        totalPrice = totalPrice - (weightCost/2);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.50;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 1;
                      totalPrice = totalPrice + (weightCost/2);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.50;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("1 Kg",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter1 > 0) {
                        counter1 = counter1 - 1;
                        totalPrice = totalPrice - weightCost;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 1.00;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter1", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter1 = counter1 + 1;
                      totalPrice = totalPrice + weightCost;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 1.00;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

      } else if (identifier.toLowerCase() == "250gm500gm") {
        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("250 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 1;
                        totalPrice = totalPrice - (weightCost/4);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.25;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 1;
                      totalPrice = totalPrice + (weightCost/4);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.25;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("500 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter1 > 0) {
                        counter1 = counter1 - 1;
                        totalPrice = totalPrice - (weightCost/2);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.50;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter1", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter1 = counter1 + 1;
                      totalPrice = totalPrice + (weightCost/2);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.50;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

      } else if (identifier.toLowerCase() == "100gm250gm") {

        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("100 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 1;
                        totalPrice = totalPrice - (weightCost/10);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.10;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 1;
                      totalPrice = totalPrice + (weightCost/10);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.10;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("250 Gm",
                  style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter1 > 0) {
                        counter1 = counter1 - 1;
                        totalPrice = totalPrice - (weightCost/4);
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalWeight = totalWeight - 0.25;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter1", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter1 = counter1 + 1;
                      totalPrice = totalPrice + (weightCost/4);
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalWeight = totalWeight + 0.25;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);
      }
    } else {

      if(identifier.toLowerCase() == "1pc3pc") {
        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("1 piece", style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 1;
                        totalPrice = totalPrice - 25.2356478;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalPc = totalPc - 1;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 1;
                      totalPrice = totalPrice + 25.256;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalPc = totalPc + 1;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);

        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("3 pieces", style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter1 > 0) {
                        counter1 = counter1 - 3;
                        totalPrice = totalPrice - 75.2356478;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalPc = totalPc - 3;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter1", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter1 = counter1 + 3;
                      totalPrice = totalPrice + 75.256;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalPc = totalPc + 3;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),

                ],
              )
            ],
          ),
        ),);

      } else if(identifier.toLowerCase() == "1pc") {
        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("1 piece", style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 1;
                        totalPrice = totalPrice - 25.2356478;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalPc = totalPc - 1;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 1;
                      totalPrice = totalPrice + 25.256;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalPc = totalPc + 1;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);
      } else if(identifier.toLowerCase() == "3pc") {
        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("3 pieces", style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 3;
                        totalPrice = totalPrice - 75.2356478;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalPc = totalPc - 3;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 3;
                      totalPrice = totalPrice + 75.256;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalPc = totalPc + 3;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);
      } else if(identifier.toLowerCase() == "6pc") {
        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("6 pieces", style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 6;
                        totalPrice = totalPrice - 150.2356478;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalPc = totalPc - 6;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 6;
                      totalPrice = totalPrice + 150.256;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalPc = totalPc + 6;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);
      } else if(identifier.toLowerCase() == "12pc") {
        mw.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("12 pieces", style: TextStyle(color: Colors.black, fontSize: 22)),
              Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      if(counter > 0) {
                        counter = counter - 12;
                        totalPrice = totalPrice - 300.2356478;
                        totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                        totalPc = totalPc - 12;
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.remove, size: 26,),),
                  SizedBox(width: 16.0,),
                  Text("$counter", style: TextStyle(fontSize: 22),),
                  SizedBox(width: 16.0,),
                  IconButton(
                    onPressed: (){
                      counter = counter + 12;
                      totalPrice = totalPrice + 300.256;
                      totalPrice = num.parse(totalPrice.toStringAsFixed(2));
                      totalPc = totalPc + 12;
                      setState(() {});
                    },
                    icon: Icon(Icons.add, size: 26,),),
                ],
              )
            ],
          ),
        ),);
      }
    }

    return mw;

  }

  void _showMessage(String message) {
    final snackBar = SnackBar(content: Text(message, style: TextStyle(fontSize: 12),));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}


