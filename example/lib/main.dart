import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color randomStatusColor = Colors.transparent;
  Color randomNavigationColor = Colors.transparent;

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  changeNavigationColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(color);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter statusbar color plugin example'),
        ),
        body: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(padding: const EdgeInsets.all(5.0)),
            new Center(
              child: new Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Set status bar color',
                    style: new TextStyle(fontSize: 20.0),
                  ),
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new FlatButton(
                    onPressed: () {
                      Color color = Colors.transparent;
                      changeStatusColor(color);
                    },
                    child: new Text('Transparent'),
                  ),
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new FlatButton(
                    onPressed: () {
                      Color color = Colors.amberAccent;
                      changeStatusColor(color);
                    },
                    child: new Text('amber-accent'),
                    color: Colors.amberAccent,
                  ),
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new FlatButton(
                    onPressed: () {
                      Color color = Colors.tealAccent;
                      changeStatusColor(color);
                    },
                    child: new Text('teal-accent'),
                    color: Colors.tealAccent,
                  ),
                  new Padding(padding: const EdgeInsets.all(10.0)),
                  new FlatButton(
                    onPressed: () {
                      Random rnd = new Random();
                      Color color = new Color.fromARGB(
                        rnd.nextInt(256),
                        rnd.nextInt(256),
                        rnd.nextInt(256),
                        rnd.nextInt(256),
                      );
                      changeStatusColor(color);
                      setState(() => randomStatusColor = color);
                    },
                    child: new Text('Random color'),
                    color: randomStatusColor,
                  ),
                ],
              ),
            ),
            new Expanded(
              child: new Center(
                child: new Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      'Set navigation bar color',
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new FlatButton(
                      onPressed: () {
                        Color color = Colors.green[400];
                        changeNavigationColor(color);
                      },
                      child: new Text('Green-400'),
                      color: Colors.green[400],
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new FlatButton(
                      onPressed: () {
                        Color color = Colors.lightBlue[100];
                        changeNavigationColor(color);
                      },
                      child: new Text('LightBlue-100'),
                      color: Colors.lightBlue[100],
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new FlatButton(
                      onPressed: () {
                        Color color = Colors.cyanAccent[200];
                        changeNavigationColor(color);
                      },
                      child: new Text('CyanAccent-200'),
                      color: Colors.cyanAccent[200],
                    ),
                    new Padding(padding: const EdgeInsets.all(10.0)),
                    new FlatButton(
                      onPressed: () {
                        Random rnd = new Random();
                        Color color = new Color.fromARGB(
                          rnd.nextInt(256),
                          rnd.nextInt(256),
                          rnd.nextInt(256),
                          rnd.nextInt(256),
                        );
                        setState(() => randomNavigationColor = color);
                        changeNavigationColor(color);
                      },
                      child: new Text('Random color'),
                      color: randomNavigationColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
