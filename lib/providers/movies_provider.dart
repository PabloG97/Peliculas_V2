import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_v2/helpers/debouncer.dart';
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

  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
    );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;



  MoviesProvider(){
    //print('MoviesProvider inicializado');
    
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getUpcomingMovies();
  }

  Map<int, List<Cast>> moviesCast = {};


  Future<String> _getJsonDAta(String endpoint, [int page = 1]) async  {
    final url = Uri.https(this._baseUrl, '3/movie/$endpoint', {
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

  Future<List<Cast>> getMovieCast(int movieId) async{

    if(moviesCast.containsKey(movieId)) return moviesCast[movieId];
    //print('GetMovieCast init');

    final jsonData = await this._getJsonDAta('${movieId}/credits');
    final creditsResponse = CreditsReponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(this._baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query' : query,
      'include_adult' : 'true'
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      //print('Tenemos un valor a buscar: $value' );
      final results = await this.searchMovies(value);
      _suggestionStreamController.add(  results );
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) { 

      debouncer.value = searchTerm;

    });

    Future.delayed(Duration(milliseconds: 301)).then(( _ ) => timer.cancel());

  }

}