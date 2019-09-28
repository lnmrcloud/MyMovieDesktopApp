import 'package:flutter/material.dart';
import 'package:example_flutter/src/pages/login.dart';
import 'package:example_flutter/src/pages/registro.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          RegistroPage(),
          LoginPage()
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}