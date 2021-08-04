import 'dart:async';
import 'dart:convert';

import 'package:climapp/src/helpers/debouncer.dart';
import 'package:climapp/src/models/result_model.dart';
import 'package:flutter/material.dart';  
import 'package:http/http.dart' as http;


class WeatherService with ChangeNotifier {

    String url_query = "https://www.metaweather.com/api/location/search/?query=";
    String url_location = "https://www.metaweather.com/api/location/";

     final debouncer = Debouncer(
        duration: Duration( milliseconds: 500 ),
      );  

    final StreamController<List<Result>> _suggestionStreamContoller = new StreamController.broadcast();
    Stream<List<Result>> get suggestionStream => this._suggestionStreamContoller.stream; 


    WeatherService(); 


    Future<List<Result>> searchLocation(String query) async {
        final url = url_query + query; 

        final res = await  http.get(Uri.parse(url)); 

        final search = resultFromJson(res.body); 

        return search;  

    } 


    void getSuggestionsByQuery( String searchTerm ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      // print('Tenemos valor a buscar: $value');
      final results = await this.searchLocation(value);
      this._suggestionStreamContoller.add( results );
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration( milliseconds: 301)).then(( _ ) => timer.cancel());
  }
  

}