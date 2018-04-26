import 'package:flutter/material.dart';

class EndPageSL extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
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

  _EndPageState(int _punteggio);

  @override
  Widget build(BuildContext context) {

    debugPrint(_punteggio.toString());

    Scaffold page = new Scaffold(
        body: new Container(
            decoration: new BoxDecoration(color: Colors.redAccent),
            child: new Center(
              child: new Text(
                'HAI PERSO!'/**\n\nPUNTEGGIO FINALE\n' + _punteggio.toString()*/,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 100.0,
                  color: Colors.white,
                ),
              )
            )
        ),
    );

    return page;
  }
}