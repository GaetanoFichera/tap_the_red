import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_the_red/View/GamePage.dart';

class HomePageSL extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new HomePageSF(),
    );
  }
}

class HomePageSF extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePageSF> {

  Size _screenSize;
  int _fontRatio = 8;

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    _screenSize = MediaQuery.of(context).size;

    Scaffold page = new Scaffold(
      body: new Container(
          decoration: new BoxDecoration(color: Colors.blueAccent),
          child: new Center(
            child: new ListView(
              children: [
                new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 17, horizontal: _screenSize.width / 110),),
                new Text(
                  'TAP THE RED!',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _screenSize.width / _fontRatio,
                    color: Colors.white,
                  ),
                ),
                new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 17, horizontal: _screenSize.width / 110),),
                new Column(
                  children: <Widget>[
                    new MaterialButton(
                      height: _screenSize.width / (1.1 * 4),
                      minWidth: _screenSize.width / (1.1 * 2),
                      color: Colors.lightBlue,
                      child: new Text(
                        'PLAY',
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _screenSize.width / (_fontRatio * 2),
                        ),
                      ),
                      textColor: Colors.white,
                      onPressed: _startGame,
                    ),
                    new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 4.5, horizontal: _screenSize.width / 110),),
                    new Text(
                      'Developed by Gaetano Fichera\n@GaetanoFichera on Github',
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: _screenSize.width / (_fontRatio * 5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );

    MaterialApp app = new MaterialApp(
      home: page,
    );

    return app;
  }

  Future _startGame() async {
    bool newGame = await Navigator.push(context, new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new GamePageSL();
        }
    ));

    if (newGame) _startGame();
  }
}