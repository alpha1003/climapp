import 'dart:async';
import 'dart:io';
import 'package:climapp/src/helpers/debouncer.dart';
import 'package:climapp/src/models/location_model.dart';
import 'package:climapp/src/models/result_model.dart';
import 'package:flutter/material.dart';  
import 'package:http/http.dart' as http;


class WeatherService with ChangeNotifier {

    String url_query = "https://www.metaweather.com/api/location/search/?query=";
    String url_location = "https://www.metaweather.com/api/location/"; 
    String urlImage = "https://www.metaweather.com/static/img/weather/png/"; 
    late Location location; 

     final debouncer = Debouncer(
        duration: Duration( milliseconds: 500 ),
      );  

    final StreamController<List<Result>> _suggestionStreamContoller = new StreamController.broadcast();
    Stream<List<Result>> get suggestionStream => this._suggestionStreamContoller.stream; 
 

    WeatherService(); 

    Future<dynamic> searchLocations(String query) async {   

        final url = url_query + query; 

        try{
            final res = await  http.get(Uri.parse(url)); 
            final search = resultFromJson(res.body); 
            return search;  
        }on SocketException catch( e ){
            return e.toString(); 
        }
    }   

    Future<dynamic> searchLocation(int id) async {
            final url = url_location + id.toString();
            try{ 
              final res = await http.get(Uri.parse(url)); 
              final data = locationFromJson(res.body); 
              location = data;  
              return data;

            } on SocketException catch (e){
               print(e.message);
               return [];   
            }

    }

    void getSuggestionsByQuery( String searchTerm ) { 

    debouncer.value = '';

    debouncer.onValue = ( value ) async {
      final results = await this.searchLocations( value );
      this._suggestionStreamContoller.add( results );
    };

    final timer = Timer.periodic(Duration(milliseconds: 50), ( _ ) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration( milliseconds: 51)).then(( _ ) => timer.cancel());
  }
  
}