
import 'package:flutter/material.dart';

class Err extends StatefulWidget {
  final Function mL;
  final String m;
  final String p_title;
  bool bar_visibility = true;
  Err({Key key, this.mL ,this.m = "",this.p_title = "", this.bar_visibility = false}) : super(key : key);

  @override
  _ErrState createState() => _ErrState();
}

class _ErrState extends State<Err> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,

        body: Center(
            child: Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(left: 32.0,right: 32.0),
                  child: Text('${widget.m}' ?? 'Something went wrong. Please try again later.', textAlign: TextAlign.center, style: TextStyle(color: Theme.of(context).primaryColor),),
                ),
                SizedBox(height: 8.0,),
                Card(
                  child: InkWell(
                      splashColor: Theme.of(context).primaryColor,
                      onTap: (){
                        widget.mL();
                      },
                      child: Container(
                          decoration: new BoxDecoration(
                              border: new Border.all(color: Theme.of(context).primaryColor, width: 0.5),
                              borderRadius: new BorderRadius.circular(4)),
                          padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 10.0,right: 10.0),
                          child: Text('Retry', style: TextStyle(color: Theme.of(context).primaryColor),))),
                )
              ],
            ))));
  }
}
