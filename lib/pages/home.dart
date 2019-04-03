import 'package:flutter/material.dart';
import '../pages/about.dart' show About;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> about = {
      'name': '大板栗',
    };
    return Scaffold(
      body: Center(
        child: RaisedButton(
          // onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => About(about))),
          onPressed: () => Navigator.of(context).pushNamed('about'),
          child: Text('open page About'),
        ),
      ),
    );
  }
}
