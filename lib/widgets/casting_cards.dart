import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/models.dart';
import 'package:peliculas_v2/providers/providers.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  
  final int movieId;

  const CastingCards({Key key, this.movieId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {

        if (!snapshot.hasData){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Cast> cast = snapshot.data;

        return Container(
          margin: EdgeInsets.only( bottom: 30),
          width: double.infinity,
          height: 190,
          //color: Colors.red,
          child: ListView.builder(
            itemCount: cast.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index)  => _CastCard(actor: cast[index]),
          ),
        );    
      },
    );
    
  }
}


class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({Key key, this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( horizontal: 10),
      width: 110,
      height: 100,
      //color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'), 
              image: NetworkImage(actor.fullProfilePath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              ),
          ),
          SizedBox(height: 5,),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}