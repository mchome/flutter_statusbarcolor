import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
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
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter statusbar color plugin example'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: 'Statusbar'),
                Tab(text: 'Navigationbar(android only)')
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Color color = Colors.transparent;
                      changeStatusColor(color);
                    },
                    child: Text('Transparent'),
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () {
                      Color color = Colors.amberAccent;
                      changeStatusColor(color);
                    },
                    child: Text('amber-accent'),
                    color: Colors.amberAccent,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () {
                      Color color = Colors.tealAccent;
                      changeStatusColor(color);
                    },
                    child: Text('teal-accent'),
                    color: Colors.tealAccent,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () {
                      Random rnd = Random();
                      Color color = Color.fromARGB(
                        rnd.nextInt(256),
                        rnd.nextInt(256),
                        rnd.nextInt(256),
                        rnd.nextInt(256),
                      );
                      changeStatusColor(color);
                      setState(() => randomStatusColor = color);
                    },
                    child: Text('Random color'),
                    color: randomStatusColor,
                  ),
                ],
              ),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Color color = Colors.green[400];
                        changeNavigationColor(color);
                      },
                      child: Text('Green-400'),
                      color: Colors.green[400],
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    FlatButton(
                      onPressed: () {
                        Color color = Colors.lightBlue[100];
                        changeNavigationColor(color);
                      },
                      child: Text('LightBlue-100'),
                      color: Colors.lightBlue[100],
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    FlatButton(
                      onPressed: () {
                        Color color = Colors.cyanAccent[200];
                        changeNavigationColor(color);
                      },
                      child: Text('CyanAccent-200'),
                      color: Colors.cyanAccent[200],
                    ),
                    Padding(padding: const EdgeInsets.all(10.0)),
                    FlatButton(
                      onPressed: () {
                        Random rnd = Random();
                        Color color = Color.fromARGB(
                          rnd.nextInt(256),
                          rnd.nextInt(256),
                          rnd.nextInt(256),
                          rnd.nextInt(256),
                        );
                        setState(() => randomNavigationColor = color);
                        changeNavigationColor(color);
                      },
                      child: Text('Random color'),
                      color: randomNavigationColor,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
