
import 'package:climapp/src/models/result_model.dart';
import 'package:climapp/src/services/weather_service.dart';
import 'package:climapp/src/shared_preferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationSearchDelegate extends SearchDelegate { 

 @override
  String? get searchFieldLabel => "Buscar ubicacion";

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
       IconButton(onPressed: () => query = " ", icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) { 

      return Text("Res"); 
    
  } 

   Widget _emptyContainer() {
      return Container(
          child: Center(
            child: Icon( Icons.location_on, color: Colors.black38, size: 130, ),
          ),
        );
    }

  @override
  Widget buildSuggestions(BuildContext context) {

        if( query.isEmpty ) {
            return _emptyContainer();
        } 

        final weatherService = Provider.of<WeatherService>(context, listen: false);
        weatherService.getSuggestionsByQuery( query );


      return StreamBuilder(
        stream: weatherService.suggestionStream,
        builder: ( _, AsyncSnapshot<List<Result>> snapshot) {
          
          if( !snapshot.hasData ) return _emptyContainer();

          final results = snapshot.data!;

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: ( _, int index ) => crearItem(context, results[ index ] ),
          );
        },
      ); 
  }


  Widget crearItem(BuildContext context, Result result) { 
    UserPreferences _prefs = UserPreferences(); 
        return ListTile(
             title: Text(result.title),
             subtitle: Text(result.locationType), 
             onTap: () async {
              
               final weatherService = Provider.of<WeatherService>(context, listen: false);
               final res = await weatherService.searchLocation(result.woeid); 
               _prefs.lastCity = result.title; 
               
               close(context, res);
                       
             },
        );
  } 




}