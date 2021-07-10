import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_v2/models/models.dart';
import 'package:peliculas_v2/models/upcoming_response.dart';


class MoviesProvider extends ChangeNotifier{

  String _apiKey = '820b98cec20977b25ef6aa990878ec98';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';


  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> upcomingMovies = [];
  int _popularPage = 0;
  int _upcomingPage = 0;

  MoviesProvider(){
    //print('MoviesProvider inicializado');
    
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getUpcomingMovies();
  }

  Future<String> _getJsonDAta(String endpoint, [int page = 1]) async  {
    var url = Uri.https(this._baseUrl, '3/movie/$endpoint', {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page'
    });

    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

      final jsonData = await this._getJsonDAta('now_playing');
      final nowPlayingResponse = NowPlayingReponse.fromJson(jsonData);
     // print( nowPlayingResponse.results[1].title);
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;
    final jsonData = await this._getJsonDAta('popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    //print(popularMovies[0]);
    notifyListeners();
  }

  getUpcomingMovies() async {
    _upcomingPage++;
    final jsonData = await this._getJsonDAta('upcoming', _upcomingPage);
    final upcomingResponse = UpcomingResponse.fromJson(jsonData);
    upcomingMovies = [...upcomingMovies, ...upcomingResponse.results];
   // print(upcomingMovies[2].title);
    notifyListeners();
  }
}