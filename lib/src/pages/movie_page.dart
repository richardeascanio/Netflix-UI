import 'package:flutter/material.dart';
import 'package:netflix_app/src/models/movie_model.dart';
import 'package:netflix_app/src/widgets/circular_clipper_widget.dart';
import 'package:netflix_app/src/widgets/content_scroll_widget.dart';

class MoviePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: _appBar(context),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              _headerPicture(movie),
              _appBar(context),
              _playButton(),
              _myListButton(),
              _shareButton()
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  movie.title.toUpperCase(),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  movie.categories,
                  style: TextStyle(color: Colors.black54, fontSize: 16.0),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  '⭐⭐⭐⭐',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Year',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          movie.year.toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Country',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          movie.country.toUpperCase(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Length',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 16.0),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          '${movie.length} min',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  height: 150.0,
                  child: SingleChildScrollView(
                    child: Text(
                      movie.description,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ContentScroll(
            images: movie.screenshots,
            title: 'ScreenShots',
            imageHeigth: 200.0,
            imageWidth: 250.0,
          ),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      elevation: 0.0,
      title: Image(
        width: 100.0,
        image: AssetImage('assets/images/netflix_logo.png'),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 30.0,
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.black,
          iconSize: 30.0,
          onPressed: () => print('Liked movie'),
        ),
      ],
    );
  }

  Widget _headerPicture(Movie movie) {
    return Container(
      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
      child: Hero(
        tag: movie.imageUrl,
        child: ClipShadowPath(
            clipper: CircularClipper(),
            shadow: Shadow(blurRadius: 20.0),
            child: Image(
              height: 400.0,
              width: double.infinity,
              image: AssetImage(movie.imageUrl),
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget _playButton() {
    return Positioned.fill(
        bottom: 10.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: RawMaterialButton(
            padding: EdgeInsets.all(10.0),
            elevation: 12.0,
            onPressed: () => print('Play video'),
            shape: CircleBorder(),
            fillColor: Colors.white,
            child: Icon(
              Icons.play_arrow,
              size: 60.0,
              color: Colors.red,
            ),
          ),
        ));
  }

  Widget _myListButton() {
    return Positioned(
      bottom: 0.0,
      left: 20.0,
      child: IconButton(
        onPressed: () => print('Add to my list'),
        icon: Icon(Icons.add),
        iconSize: 40.0,
        color: Colors.black,
      ),
    );
  }

  Widget _shareButton() {
    return Positioned(
      bottom: 0.0,
      right: 25.0,
      child: IconButton(
        onPressed: () => print('Share'),
        icon: Icon(Icons.share),
        iconSize: 35.0,
        color: Colors.black,
      ),
    );
  }
}
