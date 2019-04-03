import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final about;
  About([this.about]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(this.about ?? 'Back'),
        ),
      ),
    );
  }
}