import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '大板栗',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
