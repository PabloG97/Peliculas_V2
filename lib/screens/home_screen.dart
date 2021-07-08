import 'package:flutter/material.dart';
import 'package:peliculas_v2/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text('Cartelera'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){},
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
            CardSwiper(),
            
            MovieSlider(),
            ],
          ),
        ),
      );
  }
}
