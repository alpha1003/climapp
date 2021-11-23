import 'package:climapp/src/models/location_model.dart';
import 'package:climapp/src/view/widgets/background.dart';
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
          //clipBehavior: Clip.hardEdge,
          children: [
               Background(),
               SingleChildScrollView(
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        _initialInfo(),
                        SizedBox(height: MediaQuery.of(context).size.height*0.10,),
                        isData? _anotherInfo() : _emptyContainer(),
                    ],
                 ),
               ),
          ],
      ),
    );
  } 

  Widget _background(){
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

  Widget _initialInfo(){
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                  Container(
                    
                    child: Column( 
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            isData ? Text("${location.title}", style: style.style1,) : Text(" -- ", style: style.style1,), 
                            Icon(Icons.thermostat, size: 50, color: Colors.orange,),
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
                   mainAxisAlignment: MainAxisAlignment.center,
           
                   children: [ 
                        SizedBox(height: 75.0,),
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
      
      DateTime now = DateTime.now( );
      DateTime date1 = DateTime( now.year,now.month, now.day+1  );
      DateTime date2 = DateTime( now.year,now.month, now.day+2  );
      DateTime date3 = DateTime( now.year,now.month, now.day+3, );
      DateTime date4 = DateTime( now.year,now.month, now.day+4, );

      return Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(top: 20.0),
          height: MediaQuery.of(context).size.height*0.3, 
          width: MediaQuery.of(context).size.width*0.90,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 90, 167, 0.6), 
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30.0)),
          ),
          child: Row( 
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    _nextDays(date1,1), 
                    _nextDays(date2,2),
                    _nextDays(date3,3),
                    _nextDays(date4,4),
              ],
          ),
      ); 
  }

  Widget _emptyContainer(){
      return Container(
          
          //margin: EdgeInsets.only(top: 250.0,left: 20.0, right: 20.0),
          height: MediaQuery.of(context).size.height*0.3, 
          width: MediaQuery.of(context).size.width*0.90,
          decoration: BoxDecoration(
              color: Color.fromRGBO(0, 90, 167, 0.6), 
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
               SizedBox(height: 5.0,),
               Container(
                 width: 30,
                 height: 30,
                 child:Image(image: NetworkImage(urlImage+location.consolidatedWeather[index].weatherStateAbbr+".png")) ,
               ),
               SizedBox(height: 5.0,), 
               Text("${location.consolidatedWeather[index].weatherStateName}", style: style.style2.copyWith(fontSize: 20),),
               SizedBox(height: 5.0,),
               Text("${location.consolidatedWeather[index].theTemp.toStringAsFixed(1)}°", style: style.style3.copyWith(fontSize: 20),), 
           ],
       ),
     );
    
 } 

}