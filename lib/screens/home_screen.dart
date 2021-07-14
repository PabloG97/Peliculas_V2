import 'package:flutter/material.dart';
import 'package:peliculas_v2/providers/providers.dart';
import 'package:peliculas_v2/search/search_delegate.dart';
import 'package:peliculas_v2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  
  
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);
   // final popularProvider = Provider.of<MoviesProvider>(context);

  //  print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cartelera', textAlign: TextAlign.center),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate())
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            
            MovieSlider(
              movies: moviesProvider.popularMovies, //populares
              title: 'Popular movies', //opcional
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),

            MovieSlider(
              movies: moviesProvider.upcomingMovies, //populares
              title: 'Upcoming movies', //opcional
              onNextPage: () => moviesProvider.getUpcomingMovies(),
            ),

            ],
          ),
        ),
      );
  }
}
