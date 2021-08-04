import 'package:climapp/src/search/locationSearchDelegate.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 



  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
              IconButton(
                onPressed: () {
                   showSearch(context: context, delegate: LocationSearchDelegate()).then((value){
                     print(value.runtimeType); 
                   }); 
                   
                },
                icon: Icon(Icons.search)
             )
          ],
      ), 
      body: Stack(
          children: [
               background(),
          ],
      ),
    );
  } 

  Widget background(){

      return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight, 
                 colors: [
                     Color.fromRGBO(0, 90, 167, 36),
                     Color.fromRGBO(255, 253, 228, 100)
                 ],
              ),
          ),
      );

  } 
}