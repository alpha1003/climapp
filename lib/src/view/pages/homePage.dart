import 'package:climapp/src/models/location_model.dart';
import 'package:date_format/date_format.dart';
import 'package:climapp/src/search/locationSearchDelegate.dart';
import 'package:flutter/material.dart';
import 'package:climapp/src/view/styles.dart' as style;

class HomePage extends StatefulWidget {
  

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

 bool isData = false;
 late Location location;   

  String urlImage = "https://www.metaweather.com/static/img/weather/png/"; 

  @override  
  Widget build(BuildContext context) { 
    return Scaffold(
      appBar: AppBar(
          title: Text("ClimApp", style: style.style4,),
          actions: [
              IconButton(
                onPressed: () async {  

                   final res = await showSearch(context: context, delegate: LocationSearchDelegate());

                   if( res != null){ 
                     setState(() {
                         location = res;  
                         isData = true; 
                     }); 
                   }       
                },
                icon: Icon(Icons.search)
             )
          ],
      ), 
      body: Stack(
           
          children: [
               _background(),
               _initialInfo(),
               isData? _anotherInfo() : _emptyContainer(), 
          ],
      ),
    );
  } 

  Widget _background(){
      return Container( 
          width: double.infinity,
          height: double.infinity,
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

  Widget _initialInfo(){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    height: MediaQuery.of(context).size.width * 0.70,
                    child: Column( 
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            isData ? Text("${location.title}", style: style.style1,) : Text(" -- ", style: style.style1,),
                            _tempText("Now ",
                                     isData ? "${location.consolidatedWeather[0].theTemp.toStringAsFixed(1)}" : " -- "),
                            _tempText("Max ",
                                     isData ? "${location.consolidatedWeather[0].maxTemp.toStringAsFixed(1)}" : " -- "),
                            _tempText("Min ",
                                     isData ? "${location.consolidatedWeather[0].minTemp.toStringAsFixed(1)}" : " -- "),
                        ],
                    ),
                  ),
                Column( 
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                        isData? 
                        Text("${location.consolidatedWeather[0].weatherStateName}", style: style.style2,)
                        :Text(" -- ", style: style.style2,), 
                        Container(
                           width: MediaQuery.of(context).size.width  * 0.15,
                           height: MediaQuery.of(context).size.width * 0.15,
                           child: isData? 
                           Image(image: NetworkImage(urlImage+location.consolidatedWeather[0].weatherStateAbbr+".png")):
                           Image(image: AssetImage("images/sun.png"),)           
                        ),

                   ],
                ),  
             ],
          ),
      );
  } 

  Widget _tempText(String t1, String t2) {
        return RichText(
                text: TextSpan(
                  text: '$t1: ', 
                  style: style.style2,
                  children: [
                      TextSpan(
                         text: '$t2°', 
                         style: style.style3,
                      ),
                  ],
                ), 
              );
  }

  Widget _anotherInfo(){
      
      DateTime now = DateTime.now(); 
      DateTime date2 = DateTime(now.year,now.month, now.day+1);
      DateTime date3 = DateTime(now.year,now.month, now.day+2, );
      DateTime date4 = DateTime(now.year,now.month, now.day+3, );

      return Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(top: 300.0,left: 20.0, right: 20.0),
          height: MediaQuery.of(context).size.height*0.40, 
          width: MediaQuery.of(context).size.width*0.90,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 90, 167, 0.2), 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30.0)),
          ),
          child: Column(
            children: [
              Text("Next days", style: style.style2,),
              SizedBox(height: 20.0,),
              Row( 
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                        _nextDays(now,1), 
                        _nextDays(date2,2),
                        _nextDays(date3,3),
                        _nextDays(date4,4),
                  ],
              ),
            ],
          ),
      ); 
  }

  Widget _emptyContainer(){
      return Container(
          margin: EdgeInsets.only(top: 250.0,left: 20.0, right: 20.0),
          height: MediaQuery.of(context).size.height*0.3, 
          width: MediaQuery.of(context).size.width*0.90,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 90, 167, 0.2), 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30.0)),
          ),
          child: Center(child: Text("Next days", style: style.style2,)),
      ); 
  }

 Widget _nextDays(DateTime time, int index) {
    
     return Container(
       child: Column( 
           mainAxisSize: MainAxisSize.min,
           children: [
               Text(formatDate(time, ["D"]), style: style.style5,), 
               SizedBox(height: 10.0,),
               Container(
                 width: 30,
                 height: 30,
                 child:Image(image: NetworkImage(urlImage+location.consolidatedWeather[index].weatherStateAbbr+".png")) ,
               ),
               SizedBox(height: 10.0,), 
               Text("${location.consolidatedWeather[index].weatherStateName}", style: style.style2.copyWith(fontSize: 20),),
               SizedBox(height: 10.0,),
               Text("${location.consolidatedWeather[index].theTemp.toStringAsFixed(1)}°", style: style.style3.copyWith(fontSize: 20),),
               
               
           ],
       ),
     );
    
 } 

}