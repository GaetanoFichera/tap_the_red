import 'package:flutter/material.dart';

/*
class EndPageSL extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  }
}
*/

class EndPageSF extends StatefulWidget {
  EndPageSF({Key key, this.punteggio}) : super(key: key);

  int punteggio;

  @override
  _EndPageState createState() => new _EndPageState(punteggio);
}

class _EndPageState extends State<EndPageSF> {
  int _punteggio;

  Size _screenSize;
  int _fontRatio = 8;

  BuildContext _context;

  _EndPageState(int _punteggio);

  @override
  Widget build(BuildContext context) {

    debugPrint(_punteggio.toString());

    _context = context;

    _screenSize = MediaQuery.of(context).size;

    Scaffold page = new Scaffold(
        body: new Container(
            decoration: new BoxDecoration(color: Colors.redAccent),
            child: new Center(
              child: new ListView(
                children: [
                  new Text(
                    'HAI PERSO!'/**\n\nPUNTEGGIO FINALE\n' + _punteggio.toString()*/,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: _screenSize.width / _fontRatio,
                      color: Colors.white,
                    ),
                  ),
                  new MaterialButton(
                    height: _screenSize.width / (1.1 * 4),
                    minWidth: _screenSize.width / (1.1 * 4),
                    color: Colors.grey,
                    onPressed: () { Navigator.pop(context, true); },
                  ),
                ],
              ),
            )
        ),
    );
    return page;
  }
}