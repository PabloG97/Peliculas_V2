
import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/models.dart';
import 'package:peliculas_v2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context).settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(movie: movie),
            SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitle(movie: movie),
                _Overview(movie: movie),
                _Overview(movie: movie),
                CastingCards(movieId: movie.id),
                
              ]),
            )
          ],
        ),
      );
  }
}

class _CustomAppBar extends StatelessWidget {

  final Movie movie;
  const _CustomAppBar({Key key, @required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black38,
          padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          child: Text(
            movie.title,
            style: TextStyle( fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackDropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;
  const _PosterAndTitle({ @required this.movie});

  @override
  Widget build(BuildContext context, ) {
  
  final size = MediaQuery.of(context).size;
  final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only( top: 20),
      padding: EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                height: 175,
                width: 100,
              ),
            ),
          ),
          SizedBox( width: 15),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 185),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Text( movie.title.toString(), style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
               Text( movie.originalTitle, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 2),
               Row(
                 children: [
                   Icon( Icons.star_border_rounded, size: 20, color: Colors.lightBlue,),
                   SizedBox(width: 4.5),
                   Text(movie.voteAverage.toString(), style: textTheme.caption)
                 ],
               )
              
              ],
              
            ),
          )
          
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;
  const _Overview({Key key, @required this.movie}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}
