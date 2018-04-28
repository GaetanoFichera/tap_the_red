import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  int _bestScore = 0;

  Size _screenSize;
  double _fontRatio = 7.0;

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    _screenSize = MediaQuery
        .of(context)
        .size;

    _checkBestScore();

    Padding littlelittleSkip = new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 30, horizontal: _screenSize.width / 110),);
    Padding littleSkip = new Padding(padding: new EdgeInsets.symmetric(
        vertical: _screenSize.height / 17,
        horizontal: _screenSize.width / 110),);
    Padding bigSkip = new Padding(padding: new EdgeInsets.symmetric(
        vertical: _screenSize.height / 8,
        horizontal: _screenSize.width / 110),);

    Text welcomeText = new Text(
      'TAP THE RED!',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: _screenSize.width / _fontRatio,
        color: Colors.white,
      ),
    );

    Text textButton = new Text(
      'PLAY',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: _screenSize.width / (_fontRatio * 1.2),
      ),
    );

    MaterialButton playButton = new MaterialButton(
      height: _screenSize.width / (1.1 * 4),
      minWidth: _screenSize.width / (1.1 * 2),
      color: Colors.lightBlue,
      child: textButton,
      textColor: Colors.white,
      onPressed: _startGame,
    );

    String bestScoreStringText = '';

    Widget boxAfterPlayButton;

    if (this._bestScore > 0) {
      bestScoreStringText = 'BEST SCORE: ' + this._bestScore.toString();

      Text bestScoreText = new Text(
        bestScoreStringText,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: _screenSize.width / (_fontRatio * 2),
          color: Colors.white,
        ),
      );

      boxAfterPlayButton = new Column(
        children: <Widget>[
          littlelittleSkip,
          bestScoreText,
          littleSkip,
        ],
      );
    } else {
      boxAfterPlayButton = bigSkip;
    }

    Text textPt1 = new Text(
      'Developed by Gaetano Fichera',
      style: new TextStyle(
        color: Colors.white,
        fontSize: _screenSize.width / (_fontRatio * 3.5),
      ),
    );

    Text textPt2 = new Text(
      '@GaetanoFichera on GitHub',
      style: new TextStyle(
        color: Colors.white,
        fontSize: _screenSize.width / (_fontRatio * 3.5),
      ),
    );

    Container bottomTextBox = new Container(
      decoration: new BoxDecoration(color: Colors.blueAccent),
      child: new Center(
        child: new Column(
          children: <Widget>[
            textPt1,
            textPt2,
          ],
        ),
      ),
    );

    Container mainContainer = new Container(
        decoration: new BoxDecoration(color: Colors.blueAccent),
        child: new Center(
          child: new ListView(
            children: [
              littleSkip,
              welcomeText,
              bigSkip,
              playButton,
              boxAfterPlayButton,
              bottomTextBox,
            ],
          ),
        )
    );

    Scaffold page = new Scaffold(
      body: mainContainer,
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

  Future _checkBestScore() async {
    debugPrint('Controllo che ci sia un Punteggio salvato');
    String keyBestScore = 'bestScore';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastBestScore = prefs.get(keyBestScore) ?? 0;
    debugPrint('Punteggio Migliore: ' + this._bestScore.toString());
    if (lastBestScore > this._bestScore){
      setState(() {
        debugPrint('Punteggio migliore trovato!');
        this._bestScore = lastBestScore;
      });
    }
  }
}