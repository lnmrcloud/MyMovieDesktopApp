import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:example_flutter/src/pages/login.dart';
import 'package:example_flutter/src/pages/home_page.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyMovieApp Desktop',
      initialRoute: 'login',
      routes: {
        'login':(BuildContext context)=>LoginPage(),
        'home'     : (BuildContext context) => HomePage()
      },
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),
    );
  }
}