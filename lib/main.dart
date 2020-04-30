import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_app/src/pages/home_page.dart';
import 'package:netflix_app/src/pages/movie_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'movie': (BuildContext context) => MoviePage()
      },
    );
  }
}