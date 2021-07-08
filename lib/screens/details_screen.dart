
import 'package:flutter/material.dart';
import 'package:peliculas_v2/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
     

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _CustomAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                _PosterAndTitle(),
                _Overview(),
                _Overview(),
                CastingCards(),
                
              ]),
            )
            
            
            
          ],
        ),
      );
  }
}

class _CustomAppBar extends StatelessWidget {

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
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'movie.title',
            style: TextStyle( fontSize: 16),
          ),
        ),
        
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
  final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.only( top: 20),
      padding: EdgeInsets.symmetric( horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 175,
            ),
          ),
          SizedBox( width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text( 'movie.title', style: textTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
             Text( 'movie.originalTitle', style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
             Row(
               children: [
                 Icon( Icons.star_border_rounded, size: 20, color: Colors.lightBlue,),
                 SizedBox(width: 4.5),
                 Text('movie.voteAverage', style: textTheme.caption)
               ],
             )
            
            ],
            
          )
          
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text('Reprehenderit aliquip nulla nulla ad magna excepteur esse occaecat duis enim nisi ad irure anim. quip nulla nulla ad magna excepteur esse occaecat duis enim nisi ad irure animquip nulla nulla ad magna excepteur esse occaecat duis enim nisi ad irure anim',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,),
    );
  }
}