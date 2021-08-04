import 'package:climapp/src/models/result_model.dart';
import 'package:climapp/src/search/locationSearchDelegate.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 TextStyle style1 = TextStyle(fontSize: 60.0,color: Colors.white60,fontFamily: "alpha");
 TextStyle style2 = TextStyle(fontSize: 30.0,color: Colors.white54,fontFamily: "alpha");

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("ClimApp"),
          actions: [
              IconButton(
                onPressed: () async {
                   final res = await showSearch(context: context, delegate: LocationSearchDelegate()); 
                   
                   if( res != null) Result result = res; 
                      
                },
                icon: Icon(Icons.search)
             )
          ],
      ), 
      body: Stack(
          children: [
               background(),
               initialInfo(),
          ],
      ),
    );
  } 

  Widget background(){
      return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft, 

                 colors: [
                     Color.fromRGBO(0, 90, 167, 36),
                     Color.fromRGBO(255, 253, 228, 100)
                 ],
              ),
          ),
      );
  } 

  Widget initialInfo(){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Row(
             children: [
                  Column( 
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text("San Francisco",   style: style1,),
                          Text("Now: 23°", style: style2,),
                          Text("Max: 25°", style: style2,),
                          Text("Min: 15°", style: style2,),
                      ],
                  ),
             ],
          ),
      );
  }
}