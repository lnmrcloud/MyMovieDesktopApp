import 'package:example_flutter/src/pages/inicio.dart';
import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
import 'package:flutter/material.dart';
import 'package:example_flutter/src/pages/login.dart';
import 'package:example_flutter/src/pages/home_page.dart';
import 'package:example_flutter/src/pages/pelicula_detalle_page.dart';

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
      initialRoute: 'home',
      routes: {
        'login'   : (BuildContext context)=>LoginPage(),
        'home'    : (BuildContext context) => HomePage(),
        'inicio'   : (BuildContext context) => InicioPage(),
        'detalle' : ( BuildContext context) => PeliculaDetalle()
      },
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),
    );
  }
}