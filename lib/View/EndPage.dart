import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndPageSL extends StatelessWidget{
  int _punteggio;

  EndPageSL(this._punteggio);

  @override
  Widget build(BuildContext context) {
    return new EndPageSF(punteggio: this._punteggio);
  }
}

class EndPageSF extends StatefulWidget {
  EndPageSF({Key key, this.punteggio}) : super(key: key);

  int punteggio;

  @override
  _EndPageState createState() => new _EndPageState(punteggio);
}

class _EndPageState extends State<EndPageSF> {
  int _punteggio;

  Size _screenSize;
  double _fontRatio = 5.5;

  BuildContext _context;

  _EndPageState(this._punteggio);

  @override
  Widget build(BuildContext context) {

    debugPrint(_punteggio.toString());

    _saveScore();

    _context = context;

    _screenSize = MediaQuery.of(context).size;

    Padding littlelittleSkip = new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 30, horizontal: _screenSize.width / 110),);
    Padding littleSkip = new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 17, horizontal: _screenSize.width / 110),);
    Padding bigSkip = new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 13, horizontal: _screenSize.width / 110),);

    Text endText = new Text(
      'THE END!',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: _screenSize.width / _fontRatio,
        color: Colors.white,
      ),
    );

    Text finalScoreText = new Text(
      'FINAL SCORE: ' + this._punteggio.toString(),
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: _screenSize.width / (_fontRatio * 2),
        color: Colors.white,
      ),
    );

    Container endTextBox = new Container(
      child: new Center(
        child: new Column(
          children: <Widget>[
            endText,
            finalScoreText
          ],
        ),
      ),
    );

    Icon newGameIcon = new Icon(
      Icons.keyboard_return,
      color: Colors.white,
      size: _screenSize.width / (1.1 * 5),
    );

    MaterialButton newGameButton = new MaterialButton(
      height: _screenSize.width / (1.1 * 4),
      minWidth: _screenSize.width / (1.1 * 2),
      color: Colors.grey,
      child: newGameIcon,
      textColor: Colors.white,
      onPressed: _newGame,
    );

    Icon backHomeIcon = new Icon(
      Icons.cancel,
      color: Colors.white,
      size: _screenSize.width / (1.1 * 5),
    );

    MaterialButton backHomeButton = new MaterialButton(
    height: _screenSize.width / (1.1 * 4),
    minWidth: _screenSize.width / (1.1 * 2),
    color: Colors.grey,
    child: backHomeIcon,
    onPressed: _backHome,
    );

    Container mainContainer = new Container(
        decoration: new BoxDecoration(color: Colors.redAccent),
        child: new Center(
          child: new ListView(
            children: [
              bigSkip,
              endTextBox,
              littleSkip,
              newGameButton,
              littlelittleSkip,
              backHomeButton,
            ],
          ),
        )
    );

    Scaffold page = new Scaffold(
      body: mainContainer,
    );

    //necessario per gestire la pressione del tasto back, sennò ritornava allo stato finale della partita
    WillPopScope willPopScope = new WillPopScope(
        child: page,
        onWillPop: _backHome);

    return willPopScope;
  }

  Future<bool> _backHome(){
    Navigator.of(context).pop(false);
  }

  Future<bool> _newGame(){
    Navigator.of(context).pop(true);
  }

  Future _saveScore()async {
    debugPrint('Vedo se Aggiornare il Punteggio');
    String keyBestScore = 'bestScore';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int lastBestScore = prefs.get(keyBestScore) ?? 0;
    debugPrint('Miglior Punteggio Salvato: ' + lastBestScore.toString());
    if (this._punteggio > lastBestScore) {
      debugPrint('Aggiorno il Punteggio');
      await prefs.setInt(keyBestScore, this._punteggio);
    }

  }
}