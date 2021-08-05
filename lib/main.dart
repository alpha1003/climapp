import 'package:climapp/src/services/weather_service.dart';
import 'package:climapp/src/view/pages/homePage.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

 
void main() => runApp(MyApp()); 

 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_)=> new WeatherService() ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: EasySplashScreen(
            logo: Image(image: AssetImage("images/fond.png")),
            logoSize: 300, 
            navigator: HomePage(),
            loadingText: Text("Cargando..."),
        ), 
      ),
    );
  }
}