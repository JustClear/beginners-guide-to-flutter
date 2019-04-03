import 'package:flutter/material.dart';
import './pages/home.dart' show Home;
import './pages/about.dart' show About;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: Home(),
      routes: {
        'about': (context) => About(),
      },
    );
  }
}
