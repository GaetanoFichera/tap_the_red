import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_the_red/View/GamePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final String title = 'PTR: Push The Red';
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return new MaterialApp(
      title: this.title,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new GamePageSF(title: this.title),
    );
  }
}