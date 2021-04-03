import 'package:bhaig/HomePage/home_api.dart';
import 'package:bhaig/ListOfThings/list_of_things.dart';
import 'package:bhaig/Utils/app_models.dart';
import 'package:bhaig/Utils/connection_helper.dart';
import 'package:bhaig/Utils/constants.dart';
import 'package:bhaig/Utils/err.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:bhaig/splash_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageUI extends StatefulWidget {


  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends State<HomePageUI> {
  double h, w;
  List data = [1,2,3,4,5];

  var obj = [
    {
      "url" : "http://dexterlabs.co.in/BhaiG/banner/b1.jpg",
      "static" : "assets/b1.jpg",
    },
    {
      "url" : "http://dexterlabs.co.in/BhaiG/banner/b2.jpg",
      "static" : "assets/b2.jpg",
    },
    {
      "url" : "http://dexterlabs.co.in/BhaiG/banner/b3.jpg",
      "static" : "assets/b3.jpg",
    },
    {
      "url" : "http://dexterlabs.co.in/BhaiG/banner/b3.jpg",
      "static" : "assets/b4.jpg",
    },
  ];

  bool once = true;
  ConnectionHelper mCH;
  Future<HomePageModel> mF;
  HomeApi homeApi;
  AAAppSingleton aap;

  @override
  void initState() {
    mCH = ConnectionHelper.getInstance();
    homeApi = HomeApi();
    aap = AAAppSingleton();
    checkTimings();
    super.initState();
  }

  checkTimings() {
    if(!aap.isTimeUp) {
      mF = homeApi.GetHomePageData();
    } else {
      print("Sorry you can not order");
    }
  }

  Future<bool> checkIfOpen() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String startTime = prefs.getString("st") ?? "08";
    String endTime = prefs.getString("et") ?? "08";

    String date = DateFormat.yMEd().add_jms().format(DateTime.now());
    print(date);

    List temp = date.split(" ");
    print(temp[3].toString().toLowerCase());
    print(temp[2]);
    temp[2] = temp[2].toString().split(":").first;

    if(temp[3].toString().toLowerCase() == "am") {
      if(int.parse(startTime ?? "08") <= int.parse(temp[2]) && int.parse(temp[2]) < 12) {
        return true;
      } else {
        return false;
      }
    } else {
      if(int.parse(endTime ?? "08") > int.parse(temp[2]) || int.parse(temp[2]) == 12) {
        return true;
      } else {
        return false;
      }
    }

  }



  @override
  Widget build(BuildContext context) {

    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: aap.isTimeUp ? buildListTimeOut(context) : FutureBuilder(
            initialData: null,
            future: mF,
            builder: (context, snap) => _checkAPIData(context, snap)));
  }

  Widget _checkAPIData(BuildContext c, AsyncSnapshot snap) {
    //ConnectionState.active = snap.connectionState
    if (snap.hasData) {
      // API
      // 404
      // catch
      HomePageModel _d = snap.data;

      if (_d.status == 200 ?? 100) {
        // API true
        return _buildList(_d);
      } else if (_d.is_loading ?? false) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Please wait loading"),
              SizedBox(height: 16.0,),
              CircularProgressIndicator()
            ],
          ),
        );
      } else {
        return Err(
            bar_visibility: true,
            p_title: '',
            m: _d.Message,
            mL: () => setState(() {
              _d.is_loading = true;
              mF = homeApi.GetHomePageData();
            }));
      }
    } else {
      // initial loading
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Please wait loading"),
            SizedBox(height: 16.0,),
            CircularProgressIndicator()
          ],
        ),
      );
    }
  }

  @override
  Widget buildListTimeOut(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    //dynamic currentTime = DateFormat.jm().format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(),
          centerTitle: false,
          backgroundColor: yellow,
          title: Transform(
            transform:  Matrix4.translationValues(-(h*0.070), 0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text("What can we get you?", style: TextStyle(color: grey, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontFamily: 'Schyler'),),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CarouselSlider(
                    options: CarouselOptions(height: h*0.28,
                        aspectRatio: 16/9,
                        autoPlay: true,
                        autoPlayInterval: Duration(milliseconds: 2200),
                        initialPage: 0,
                        pauseAutoPlayOnTouch: true,
                        pauseAutoPlayInFiniteScroll: true
                    ),
                    items: obj.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 4, right: 4),
                            child: Container(
//                  color: Colors.green,
                              child: Material(
                                  color: Colors.white,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    elevation: 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            color: Colors.white,
                                            child: FadeInImage(
                                              fit: BoxFit.cover,
                                              fadeInDuration: Duration(milliseconds: 1),
                                              fadeOutDuration: Duration(milliseconds: 1),
                                              placeholder: AssetImage("assets/sb.jpg"),
                                              image: AssetImage("${i['static']}"),
                                            ),
//                                              child: CachedNetworkImage(
//                                                imageUrl: '${i['url']}',
//                                                imageBuilder: (context, imageProvider) => Container(
//                                                  decoration: BoxDecoration(
//                                                    image: DecorationImage(
//                                                      image: imageProvider,
//                                                      fit: BoxFit.cover,
//                                                    ),
//                                                  ),
//                                                ),
//                                                placeholder: (context, url) => Image.asset("assets/sb.jpg", fit: BoxFit.cover,),
//                                                errorWidget: (context, url, error) => Icon(Icons.error),
//                                              ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8.0, right: 8.0),
                  child: Card(
                    elevation: 5.0,
                    color: yellow,
                    child: Column(
                      children: <Widget>[

                        SizedBox(height: 16.0,),
                        Container(
                          width: w,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () async{

                                  bool result = await checkIfOpen();

                                  if(result) {
                                    setState(() {
                                      aap.isTimeUp = false;
                                      mF = homeApi.GetHomePageData();
                                    });
                                  } else {
                                    AwesomeDialog(
                                      dismissOnBackKeyPress: true,
                                      context: context,
                                      dismissOnTouchOutside: true,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.TOPSLIDE,
                                      customHeader: Image.asset(
                                        'assets/logofinal.png', fit: BoxFit.cover,),
                                      title: 'Sorry',
                                      desc: 'We deliver only from ${aap.start}:00 AM to ${aap.end}:00 PM',

                                    )..show();
                                  }
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/vegetable.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0,),
                              InkWell(
                                onTap: () async {

                                  bool result = await checkIfOpen();

                                  if(result) {
                                    setState(() {
                                      aap.isTimeUp = false;
                                      mF = homeApi.GetHomePageData();
                                    });
                                  } else {
                                    AwesomeDialog(
                                      dismissOnBackKeyPress: true,
                                      context: context,
                                      dismissOnTouchOutside: true,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.TOPSLIDE,
                                      customHeader: Image.asset(
                                        'assets/logofinal.png', fit: BoxFit.cover,),
                                      title: 'Sorry',
                                      desc: 'We deliver only from ${aap.start}:00 AM to ${aap.end}:00 PM',

                                    )..show();
                                  }
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/fruits.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0,),
                        Container(
                          width: w,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  bool result = await checkIfOpen();

                                  if(result) {
                                    setState(() {
                                      aap.isTimeUp = false;
                                      mF = homeApi.GetHomePageData();
                                    });
                                  } else {
                                    AwesomeDialog(
                                      dismissOnBackKeyPress: true,
                                      context: context,
                                      dismissOnTouchOutside: true,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.TOPSLIDE,
                                      customHeader: Image.asset(
                                        'assets/logofinal.png', fit: BoxFit.cover,),
                                      title: 'Sorry',
                                      desc: 'We deliver only from ${aap.start}:00 AM to ${aap.end}:00 PM',

                                    )..show();
                                  }
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/namkeen.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0,),
                              InkWell(
                                onTap: (){
//                                  Navigator.push(
//                                    context,
//                                    PageRouteBuilder(
//                                      settings: RouteSettings(name: '/list_of_things'),
//                                      pageBuilder: (c, a1, a2) => ListOfThingsPage(),
//                                      transitionsBuilder: (c, anim, a2, child) =>
//                                          FadeTransition(opacity: anim, child: child),
//                                      transitionDuration: Duration(milliseconds: 500),
//                                    ),
//                                  );
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/dairy.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0,),
                      ],
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.phoneAlt, color: grey,),
                    SizedBox(width: 16.0,),
                    Text("Call us at: 9757350259", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: grey, fontFamily: 'Schyler'),)
                  ],
                ),
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildList(HomePageModel d) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    //dynamic currentTime = DateFormat.jm().format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Container(),
          centerTitle: false,
          backgroundColor: yellow,
          title: Transform(
            transform:  Matrix4.translationValues(-(h*0.070), 0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text("What can we get you?", style: TextStyle(color: grey, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontFamily: 'Schyler'),),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CarouselSlider(
                    options: CarouselOptions(height: h*0.28,
                        aspectRatio: 16/9,
                        autoPlay: true,
                        autoPlayInterval: Duration(milliseconds: 2200),
                        initialPage: 0,
                        pauseAutoPlayOnTouch: true,
                        pauseAutoPlayInFiniteScroll: true
                    ),
                    items: obj.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, bottom: 10.0, left: 4, right: 4),
                            child: Container(
//                  color: Colors.green,
                              child: Material(
                                  color: Colors.white,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Material(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    elevation: 4,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            color: Colors.white,
                                            child: FadeInImage(
                                              fit: BoxFit.cover,
                                              fadeInDuration: Duration(milliseconds: 1),
                                              fadeOutDuration: Duration(milliseconds: 1),
                                              placeholder: AssetImage("assets/sb.jpg"),
                                              image: AssetImage("${i['static']}"),
                                            ),
//                                              child: CachedNetworkImage(
//                                                imageUrl: '${i['url']}',
//                                                imageBuilder: (context, imageProvider) => Container(
//                                                  decoration: BoxDecoration(
//                                                    image: DecorationImage(
//                                                      image: imageProvider,
//                                                      fit: BoxFit.cover,
//                                                    ),
//                                                  ),
//                                                ),
//                                                placeholder: (context, url) => Image.asset("assets/sb.jpg", fit: BoxFit.cover,),
//                                                errorWidget: (context, url, error) => Icon(Icons.error),
//                                              ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, left: 8.0, right: 8.0),
                  child: Card(
                    elevation: 5.0,
                    color: yellow,
                    child: Column(
                      children: <Widget>[

                        SizedBox(height: 16.0,),
                        Container(
                          width: w,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () async {

                                  bool isOpen = await checkIfOpen();

                                  if(isOpen) {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        settings: RouteSettings(name: '/list_of_things'),
                                        pageBuilder: (c, a1, a2) => ListOfThingsPage(
                                          id: 1,
                                        ),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 500),
                                      ),
                                    );
                                  } else {
                                    AwesomeDialog(
                                      dismissOnBackKeyPress: true,
                                      context: context,
                                      dismissOnTouchOutside: true,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.TOPSLIDE,
                                      customHeader: Image.asset(
                                        'assets/logofinal.png', fit: BoxFit.cover,),
                                      title: 'Sorry',
                                      desc: 'We deliver only from ${aap.start}:00 AM to ${aap.end}:00 PM',

                                    )..show();
                                  }

                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/vegetable.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0,),
                              InkWell(
                                onTap: () async {

                                  bool isOpen = await checkIfOpen();

                                  if(isOpen) {

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      settings: RouteSettings(name: '/list_of_things'),
                                      pageBuilder: (c, a1, a2) => ListOfThingsPage(
                                        id: 2,
                                      ),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 500),
                                    ),
                                  );
                                  } else {
                                    AwesomeDialog(
                                      dismissOnBackKeyPress: true,
                                      context: context,
                                      dismissOnTouchOutside: true,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.TOPSLIDE,
                                      customHeader: Image.asset(
                                        'assets/logofinal.png', fit: BoxFit.cover,),
                                      title: 'Sorry',
                                      desc: 'We deliver only from ${aap.start}:00 AM to ${aap.end}:00 PM',

                                    )..show();
                                  }
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/fruits.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0,),
                        Container(
                          width: w,
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            children: <Widget>[
                              InkWell(
                                onTap: () async {

                                  bool isOpen = await checkIfOpen();

                                  if(isOpen) {

                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      settings: RouteSettings(name: '/list_of_things'),
                                      pageBuilder: (c, a1, a2) => ListOfThingsPage(
                                        id: 3,
                                      ),
                                      transitionsBuilder: (c, anim, a2, child) =>
                                          FadeTransition(opacity: anim, child: child),
                                      transitionDuration: Duration(milliseconds: 500),
                                    ),
                                  );
                                  } else {
                                    AwesomeDialog(
                                      dismissOnBackKeyPress: true,
                                      context: context,
                                      dismissOnTouchOutside: true,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.TOPSLIDE,
                                      customHeader: Image.asset(
                                        'assets/logofinal.png', fit: BoxFit.cover,),
                                      title: 'Sorry',
                                      desc: 'We deliver only from ${aap.start}:00 AM to ${aap.end}:00 PM',

                                    )..show();
                                  }
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/namkeen.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0,),
                              InkWell(
                                onTap: (){
//                                  Navigator.push(
//                                    context,
//                                    PageRouteBuilder(
//                                      settings: RouteSettings(name: '/list_of_things'),
//                                      pageBuilder: (c, a1, a2) => ListOfThingsPage(),
//                                      transitionsBuilder: (c, anim, a2, child) =>
//                                          FadeTransition(opacity: anim, child: child),
//                                      transitionDuration: Duration(milliseconds: 500),
//                                    ),
//                                  );
                                },
                                child: Card(
                                  child: Container(
                                    height: h*0.2,
                                    width: w/2-40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage('assets/dairy.jpg'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0,),
                      ],
                    ),
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
//                  child: Card(
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(10.0),
//                    ),
//                    child: Container(
//                      padding: EdgeInsets.all(16.0),
//                      decoration: BoxDecoration(
//                        color: yellow,
//                        borderRadius: BorderRadius.circular(10.0),
//                      ),
//                      height: h*0.28,
//                      child: ListView.builder(
//                          shrinkWrap: true,
//                          itemCount: data.length,
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (BuildContext context, int i){
//                            return GestureDetector(
//                              onTap: (){
//                                Navigator.push(
//                                  context,
//                                  PageRouteBuilder(
//                                    settings: RouteSettings(name: '/list_of_items'),
//                                    pageBuilder: (c, a1, a2) => ListOfThingsPage(
//                                      id : data[i],
//                                    ),
//                                    transitionsBuilder: (c, anim, a2, child) =>
//                                        FadeTransition(opacity: anim, child: child),
//                                    transitionDuration: Duration(milliseconds: 500),
//                                  ),
//                                );
//                              },
//                              child: Container(
//                                  width: w/2-32,
//                                  height: h*0.24,
//                                  padding: EdgeInsets.only(left: 8.0, right: 4.0),
//                                  child: Card(child: Container(
//
//                                      child: Image.asset("assets/c1.jpg", fit: BoxFit.cover,)))
//                              ),
////                      child: Container(
////                          width: w/2-32,
////                          padding: EdgeInsets.only(left: 8.0, right: 4.0),
////                          child: Card(child: Container(
////                              color: Colors.blueAccent,
////                              child: Center(child: Text("Category ${data[i]}", style: TextStyle(fontSize: 22),))))),
//                            );
//                          }),
//                    ),
//                  ),
//                ),

//                Padding(
//                  padding: const EdgeInsets.only(top: 16.0, bottom: 40.0),
//                  child: CarouselSlider(
//                    options: CarouselOptions(height: h*0.30,
//                        aspectRatio: 16/9,
//                        autoPlay: false,
//                        autoPlayInterval: Duration(milliseconds: 1800),
//                        initialPage: 0,
//                        pauseAutoPlayOnTouch: false,
//                        pauseAutoPlayInFiniteScroll: false
//                    ),
//                    items: [1,2,3,4,5].map((i) {
//                      return Builder(
//                        builder: (BuildContext context) {
//                          return Card(
//                            elevation: 3.0,
//                            child: Container(
//                                width: MediaQuery.of(context).size.width,
//                                margin: EdgeInsets.symmetric(horizontal: 5.0),
//                                padding: EdgeInsets.all(16.0),
//                                decoration: BoxDecoration(
//                                    color: Colors.white,
//                                    borderRadius: BorderRadius.circular(10.0)
//                                ),
//                                child: Image.asset("assets/demo.jpeg",
//                                  fit: BoxFit.cover,)
//                            ),
//                          );
//                        },
//                      );
//                    }).toList(),
//                  ),
//                ),
                SizedBox(height: 32.0,),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: h*0.08,
                width: w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(FontAwesomeIcons.phoneAlt, color: grey,),
                    SizedBox(width: 16.0,),
                    Text("Call us at: ${d.data.ContactUsInfo ?? 9757350259}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: grey, fontFamily: 'Schyler'),)
                  ],
                ),
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//+91 8850228469