import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

  String _apiKey = '820b98cec20977b25ef6aa990878ec98';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  MoviesProvider(){
    //print('MoviesProvider inicializado');
    
    this.geOnDisplayMovies();
  }


  geOnDisplayMovies() async {

    //var url = Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
    var url = Uri.https(this._baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
      });

      final response = await http.get(url);
      print(url);
      print( response.body);
  }
}