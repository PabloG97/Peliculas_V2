import 'package:flutter/material.dart';
import 'package:peliculas_v2/models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String title;
  final Function onNextPage;

  const MovieSlider({
    Key key,
    @required this.movies, 
    this.title='', 
    @required this.onNextPage
    }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {

    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 750) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override

  
  Widget build(BuildContext context) {

    
    
    return Container(
      width: double.infinity,
      height: 280,
      //color: Colors.red, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: EdgeInsets.symmetric( horizontal: 20),
            child: Text(widget.title, style: TextStyle( fontSize: 25.0, fontWeight: FontWeight.bold),)
          ),

          SizedBox(
            height: 7,
          ),

          

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) {
                Movie movie = widget.movies[index];
                
                return _MoviePoster(movie: movie, heroId: '${widget.title}-$index-${widget.movies[0].id}');
              } 
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {


  final Movie movie;
  final String heroId;

  const _MoviePoster({Key key, @required this.movie, @required this.heroId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    movie.heroId = this.heroId;

    return Container (
      width: 130,
      height: 190,
     // color: Colors.green,
      margin: EdgeInsets.symmetric( horizontal:  10),
      child: Column(
        children: [
          
          
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox( height: 5,),

          Text( 
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}