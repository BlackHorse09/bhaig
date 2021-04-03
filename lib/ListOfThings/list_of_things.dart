import 'package:bhaig/PlaceOrder/place_order.dart';
import 'package:bhaig/Utils/app_models.dart';
import 'package:bhaig/Utils/constants.dart';
import 'package:bhaig/Utils/err.dart';
import 'package:bhaig/Utils/singleton.dart';
import 'package:bhaig/AddToCart/add_to_cart_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'list_of_things_api.dart';

class ListOfThingsPage extends StatefulWidget {

  int id;

  ListOfThingsPage({Key key, this.id}) : super(key : key);

  @override
  _ListOfThingsPageState createState() => _ListOfThingsPageState();
}

class _ListOfThingsPageState extends State<ListOfThingsPage> {

  TextEditingController search = new TextEditingController();
  List<CategrotyData> displayData = [];
  bool once = true;
  GetListAPI getListAPI;
  Future<CategrotyModel> mF;
  double h,w;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AAAppSingleton aap;
  bool isFruit;

  @override
  void initState() {
    aap = AAAppSingleton();
    getListAPI = GetListAPI();
    mF = getListAPI.GetListItemsFromAPI(widget.id, false);
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      mF = getListAPI.GetListItemsFromAPI(widget.id, true);
    });

    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Widget build(BuildContext context) {

    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
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
      CategrotyModel _d = snap.data;

      if (_d.status == 200 ?? 100) {
        // API true
        return _buildList(context, _d);
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
              mF = getListAPI.GetListItemsFromAPI(widget.id, false);
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


  Widget _buildList(BuildContext c, CategrotyModel d) {

    print(h);

    if(once) {
      displayData = d.data;
      once = false;
    }  else if(d.ApiStatus) {
      displayData = d.data;
      d.ApiStatus = false;
    }
    return SafeArea(
      child: Scaffold(

        floatingActionButton: aap.addCartObj.length != 0 ? FloatingActionButton.extended(

          backgroundColor: yellow,
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.push(
              context,
              PageRouteBuilder(
                settings: RouteSettings(name: '/place_order'),
                pageBuilder: (c, a1, a2) => PlaceOrder(notifyParent : refreshData),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: Duration(milliseconds: 500),
              ),
            );
          },
          icon: IconButton(
            icon: Icon(FontAwesomeIcons.shoppingCart, color: grey,),
          ),
          label: Text("Cart(${aap.addCartObj.length})", style: TextStyle(color: grey, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontFamily: 'Schyler', fontSize: 15),),
        ) : Container(),

        appBar: AppBar(
          backgroundColor: yellow,
            leading: Container(),
            centerTitle: false,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: (){
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        settings: RouteSettings(name: '/place_order'),
                        pageBuilder: (c, a1, a2) => PlaceOrder(notifyParent : refreshData),
                        transitionsBuilder: (c, anim, a2, child) =>
                            FadeTransition(opacity: anim, child: child),
                        transitionDuration: Duration(milliseconds: 500),
                      ),
                    );
                  },
                  icon: Icon(FontAwesomeIcons.shoppingCart, color: grey,),
                ),
              )
            ],
            title: Transform(
              transform:  Matrix4.translationValues(-(h*0.070), 0.0, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(left: 8),
                margin: EdgeInsets.only(top: 12.0),
                child: TextField(
                  controller: search,
                  onChanged: (text) {
                    text = text.toLowerCase();
                    setState(() {
                      displayData = d.data.where((element) {
                        var nameVeg = element.Name.toLowerCase();
                        //return nameVeg.contains(text);
                        if(nameVeg.contains(text)) {
                          return true;
                        } else {
                          var tagName = element.Tag.toString().toLowerCase();
                          if(tagName.contains(text)) {
                            return true;
                          } else {
                            return false;
                          }
                        }
                      }).toList();
                    });
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ' Search here'
                  ),
                ),
              ),
            ),

            bottom: PreferredSize(preferredSize: Size(double.infinity, 10), child: Container(),)

        ),
        body: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: RefreshIndicator(
            color: Color(0xff323639),
            onRefresh: refreshList,
            key: refreshKey,
            child: ListView.builder(
                itemCount: displayData.length,
                itemBuilder: (context, int i){
                  return displayData[i].Display ?  Column(
                    children: <Widget>[
                      Container(
                        height: 85.0,

                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          //color: Color(0xff),

                          child: Padding(
                              padding: const EdgeInsets.only(right : 8.0, top: 8.0, bottom: 8.0, left: 0.0),
                              child: ListTile(
                                  onTap: () async {
                                    FocusScopeNode currentFocus = FocusScope.of(context);

                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    var results = await Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        settings: RouteSettings(name: '/add_to_cart'),
                                        pageBuilder: (c, a1, a2) => AddToCartPageUi(
                                            weightIdentifier : displayData[i].WeightIdentifier,
                                            name : displayData[i].Name,
                                            cost : displayData[i].Cost,
                                            category : displayData[i].Category,
                                            image : displayData[i].ListImage ?? "",
                                            stock : displayData[i].Stock,
                                            p_id : displayData[i].ProductCode,
                                            display : displayData[i].Display
                                        ),
                                        transitionsBuilder: (c, anim, a2, child) =>
                                            FadeTransition(opacity: anim, child: child),
                                        transitionDuration: Duration(milliseconds: 500),
                                      ),
                                    );

                                    if(results != null) {
                                      if(results.containsKey('done') && results['done']) {
                                        setState(() {});
                                      }
                                    }

                                  },
                                  title: Text("${displayData[i].Name}", style: TextStyle(color: grey, fontSize: 18, fontFamily: 'Schyler'),maxLines: 2,overflow: TextOverflow.ellipsis,),
                                  trailing: displayData[i].WeightIdentifier.toLowerCase().contains("kg") ||  displayData[i].WeightIdentifier.toLowerCase().contains("gm") ? Text("₹ ${displayData[i].Cost}/Kg", style: TextStyle(color: grey, fontSize: 18, fontFamily: 'Schyler'),) :
                                  Text("₹ ${displayData[i].Cost}/Pc", style: TextStyle(color: grey, fontSize: 18, fontFamily: 'Schyler'),),
                                 // leading: Image.asset("assets/demo.jpeg", fit: BoxFit.cover,)
                              leading: CachedNetworkImage(
                                imageUrl: '${displayData[i].ListImage}',
                                placeholder: (context, url) => CircularProgressIndicator(),
                                errorWidget: (context, url, error) => Container(
                                    child: widget.id == 3 ? Image.asset('assets/namkeenstatic.jpg', fit: BoxFit.cover) : Image.asset('assets/staticproduct.jpg', fit: BoxFit.cover),
                                ),
                              ),
                              )
                          ),
                        ) ,
                      )
                    ],
                  ) : Container();
                }),
          ),
        ),
      ),
    );
  }

  refreshData() {
    setState(() {});
  }
}
