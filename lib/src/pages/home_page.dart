import 'package:flutter/material.dart';
import 'package:netflix_app/src/models/movie_model.dart';
import 'package:netflix_app/src/widgets/content_scroll_widget.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _createAppBar(),
      body: _createListView(),
    );
  }

  Widget _createAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      title: Image(
        width: 100.0,
        image: AssetImage('assets/images/netflix_logo.png'),
      ),
      leading: IconButton(
        padding: EdgeInsets.only(left: 30.0),
        onPressed: () => print('Menu'),
        icon: Icon(Icons.menu),
        iconSize: 30.0,
        color: Colors.black,
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: 30.0),
          icon: Icon(Icons.search),
          onPressed: () => print('Search'),
          iconSize: 30.0,
          color: Colors.black,
        )
      ],
    );
  }

  Widget _createListView() {
    return ListView(
      children: <Widget>[
        Container(
          height: 280.0,
          width: double.infinity,
          child: PageView.builder(
            controller: _pageController,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              return _movieSelector(index);
            }
          ),
        ),
        Container(
          height: 90.0,
          child: _labelsList(),
        ),
        SizedBox(height: 20.0,),
        ContentScroll(images: myList, title: 'My List', imageHeigth: 250.0, imageWidth: 150.0,),
        SizedBox(height: 10.0,),
        ContentScroll(images: popular, title: 'Popular', imageHeigth: 250.0, imageWidth: 150.0,),
      ],
    );
  }

  Widget _movieSelector(int index) {
    // Para android hacemos wrap al AnimatedBuilder con un ClipRRect para que se vea el blur bien
    return ClipRRect(
      child: AnimatedBuilder(
        animation: _pageController,
        builder: (BuildContext context, Widget widget) {
          // Para hacer que las demas cards del selector se vean mas peque;as a la que esta seleccionada
          double value = 1;
          if (_pageController.position.haveDimensions) {
            value = _pageController.page - index;
            value = (1 - (value.abs() * 0.3) + 0.04).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              height: Curves.easeInOut.transform(value) * 270.0,
              width: Curves.easeInOut.transform(value) * 400.0,
              child: widget,
            ),
          );
        },
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, 'movie', arguments: movies[index]),
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.0, 4.0),
                        blurRadius: 10.0
                      )
                    ],
                  ),
                  child: Center(
                    child: Hero(
                      tag: movies[index].imageUrl,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          image: AssetImage(movies[index].imageUrl),
                          height: 220.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.0,
                bottom: 40.0,
                child: Container(
                  width: 250.0,
                  child: Text(
                    movies[index].title.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _labelsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      scrollDirection: Axis.horizontal,
      itemCount: labels.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.all(10.0),
          width: 160.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFD45253),
                Color(0xFF9E1F28)
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF9E1F28),
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0
              ),
            ],
          ),
          child: Center(
            child: Text(
              labels[index].toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.8
              ),
            ),
          ),
        );
      },
    );
  }
}