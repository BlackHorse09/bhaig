import 'package:bhaig/ListOfThings/list_of_things.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageUI extends StatefulWidget {
  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  double h, w;
  List data = [1,2,3,4,5];

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    //dynamic currentTime = DateFormat.jm().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: Text("What can we get you?"),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CarouselSlider(
                  options: CarouselOptions(height: h*0.30,
                      aspectRatio: 16/9,
                      autoPlay: true,
                      autoPlayInterval: Duration(milliseconds: 1800),
                      initialPage: 0,
                      pauseAutoPlayOnTouch: true,
                      pauseAutoPlayInFiniteScroll: true
                  ),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          elevation: 15.0,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Image.asset("assets/demo.jpeg",
                                fit: BoxFit.cover,)
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    height: h*0.28,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int i){
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  settings: RouteSettings(name: '/list_of_items'),
                                  pageBuilder: (c, a1, a2) => ListOfThingsPage(),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(opacity: anim, child: child),
                                  transitionDuration: Duration(milliseconds: 500),
                                ),
                              );
                            },
                            child: Container(
                                width: w/2-32,
                                padding: EdgeInsets.only(left: 8.0, right: 4.0),
                                child: Card(child: Container(
                                    color: Colors.blueAccent,
                                    child: Image.asset("assets/demo200.jpeg", fit: BoxFit.cover,)))),
//                      child: Container(
//                          width: w/2-32,
//                          padding: EdgeInsets.only(left: 8.0, right: 4.0),
//                          child: Card(child: Container(
//                              color: Colors.blueAccent,
//                              child: Center(child: Text("Category ${data[i]}", style: TextStyle(fontSize: 22),))))),
                          );
                        }),
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 40.0),
                child: CarouselSlider(
                  options: CarouselOptions(height: h*0.30,
                      aspectRatio: 16/9,
                      autoPlay: false,
                      autoPlayInterval: Duration(milliseconds: 1800),
                      initialPage: 0,
                      pauseAutoPlayOnTouch: false,
                      pauseAutoPlayInFiniteScroll: false
                  ),
                  items: [1,2,3,4,5].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Card(
                          elevation: 15.0,
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Image.asset("assets/demo.jpeg",
                                fit: BoxFit.cover,)
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 32.0,),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: h*0.08,
              width: w,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
