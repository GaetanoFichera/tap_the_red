import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tap_the_red/View/EndPage.dart';

class GamePageSL extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new GamePageSF();
  }
}

class GamePageSF extends StatefulWidget {
  //GamePageSF({Key key, this.title}) : super(key: key);

  @override
  _GamePageState createState() => new _GamePageState();
}

class _GamePageState extends State<GamePageSF> {
  BuildContext _context;
  final Color _colorDisattivato = Colors.lightBlueAccent;
  final Color _colorAttivato = Colors.redAccent;

  int _punteggio = 0;
  int _buttonsN = 16;
  int _gridDim = 0;

  int _punteggioIncrementoTimer = 10;

  Timer _timer;

  Size _screenSize;
  int _fontRatio = 10;

  List<bool> _buttonStates;

  int _livello = 1;
  int _sogliaIncLivello = 5;

  Duration _delay;

  Widget _buildOverGrid(){
    return new Text(
      "LEVEL " + _livello.toString() + "\nPOINTS " + _punteggio.toString(),
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: _screenSize.width/_fontRatio,
        color: Colors.white,
      ),
    );
  }

  Widget _buildOneButton(int buttonPos){
    final activated = _buttonStates[buttonPos];

    return new MaterialButton(
      height: _screenSize.width / (1.1 * _gridDim),
      minWidth: _screenSize.width / (1.1 * _gridDim),
      color: activated ? _colorAttivato : _colorDisattivato,
      onPressed: activated ? (){
        setState(() {
          _punteggio++;
          _buttonStates[buttonPos] = !_buttonStates[buttonPos];
          if (_increaseLivello()) _speedTimer();
          debugPrint('Tasto Premuto!');
        });
      } : _endGame,
    );
  }

  Widget _buildOneRow(List<Widget> widgets){
    return new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widgets
    );
  }

  Widget _buildButtonGrid(){
    _gridDim = sqrt(_buttonsN).round();

    List<Widget> rowsButtons = new List();

    for (int buttonIndex = 0; buttonIndex < _buttonsN; ){
      List<Widget> oneRowButtons = new List();

      for (int buttonOnOneRowIndex = 0; buttonOnOneRowIndex < _gridDim; buttonOnOneRowIndex++){
        oneRowButtons.add(_buildOneButton(buttonIndex));
        buttonIndex++;
      }

      rowsButtons.add(_buildOneRow(oneRowButtons));
      rowsButtons.add(new Padding(
        padding: new EdgeInsets.symmetric(vertical: _screenSize.width / 100, horizontal: _screenSize.width / 1000),));
    }

    return new Column(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: rowsButtons,
    );
  }

  Widget _buildMainBox(){
    return new Column(
      children: <Widget>[
        new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 17, horizontal: _screenSize.width / 110),),
        _buildOverGrid(),
        new Padding(padding: new EdgeInsets.symmetric(vertical: _screenSize.height / 17, horizontal: _screenSize.width / 110),),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          child: _buildButtonGrid(),
        )

      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _buttonStates = new List();

    //inizializzo lo stato dei bottoni
    for (int i = 0; i < _buttonsN; i++) _buttonStates.add(false);

    _delay = const Duration(milliseconds:1000);
    _timer = Timer.periodic(_delay, (Timer t) => _addRedButton());
  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    _screenSize = MediaQuery.of(context).size;

    Scaffold page = new Scaffold(
      body: new Container(
          decoration: new BoxDecoration(color: Colors.blueAccent),
          child: new Center(
        child: _buildMainBox(),)
      )
    );

    return page;
  }

  void _addRedButton(){
    debugPrint('Sono nella callback del Timer');
    if (_IsEndGame()) {
      _endGame();
    } else {
      setState(() {
        Random random = new Random();
        int randomPos = random.nextInt(_buttonsN);
        _buttonStates[randomPos] = true;
      });
    }
  }

  void _endGame()async {
    _stopTimer();

    /* la funzione che la contiene deve ridare "Future"

    Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
        (context, animation, secondaryAnimation) {
      // directly construct the your widget here with whatever object you want
      // to pass in.
          debugPrint(_punteggio.toString());
          return new EndPageSF(punteggio: _punteggio,);
    }));
    */

    bool newGame = await Navigator.push(context, new MaterialPageRoute<bool>(
        builder: (BuildContext context) {
          return new EndPageSL(this._punteggio);
        }
    ));

    if (newGame) Navigator.pop(context, true);
    else Navigator.pop(context, false);
  }

  bool _IsEndGame(){
    //return false;
    for (int i = 0; i < _buttonStates.length; i++) {
      if (!_buttonStates[i]) return false;
    }
      //fermo il timer
      return true;
  }

  void _stopTimer(){
    _timer.cancel();
  }

  bool _increaseLivello(){
    if (_livello * _sogliaIncLivello == _punteggio){
      _livello++;
      debugPrint('Nuovo Livello! - ' + _livello.toString());
      return true;
    }else return false;
  }

  void _speedTimer() {
    if (_delay >= const Duration(milliseconds:200)){
      _timer.cancel();
      _delay = _delay - const Duration(milliseconds:150);
      _timer = Timer.periodic(_delay, (Timer t) => _addRedButton());
      debugPrint('Timer Speed Up! ' + 'Nuovo Delay: ' + _delay.toString());
    }
  }
}