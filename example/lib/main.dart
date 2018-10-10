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
  Color randomStatusColor = Colors.black;
  Color randomNavigationColor = Colors.black;

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  changeNavigationColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(color);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
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
                    onPressed: () => changeStatusColor(Colors.transparent),
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
                    onPressed: () => changeStatusColor(Colors.tealAccent),
                    child: Text('teal-accent'),
                    color: Colors.tealAccent,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        FlutterStatusbarcolor.setStatusBarWhiteForeground(true),
                    child: Text(
                      'light foreground',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        FlutterStatusbarcolor.setStatusBarWhiteForeground(
                            false),
                    child: Text('dark foreground'),
                    color: Colors.white,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () {
                      Random rnd = Random();
                      Color color = Color.fromARGB(
                        255,
                        rnd.nextInt(255),
                        rnd.nextInt(255),
                        rnd.nextInt(255),
                      );
                      changeStatusColor(color);
                      setState(() => randomStatusColor = color);
                    },
                    child: Text(
                      'Random color',
                      style: TextStyle(
                        color: useWhiteForeground(randomStatusColor)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    color: randomStatusColor,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => changeNavigationColor(Colors.green[400]),
                    child: Text('Green-400'),
                    color: Colors.green[400],
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        changeNavigationColor(Colors.lightBlue[100]),
                    child: Text('LightBlue-100'),
                    color: Colors.lightBlue[100],
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        changeNavigationColor(Colors.cyanAccent[200]),
                    child: Text('CyanAccent-200'),
                    color: Colors.cyanAccent[200],
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        FlutterStatusbarcolor.setNavigationBarWhiteForeground(
                            true),
                    child: Text(
                      'light foreground',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        FlutterStatusbarcolor.setNavigationBarWhiteForeground(
                            false),
                    child: Text('dark foreground'),
                    color: Colors.white,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () {
                      Random rnd = Random();
                      Color color = Color.fromARGB(
                        255,
                        rnd.nextInt(255),
                        rnd.nextInt(255),
                        rnd.nextInt(255),
                      );
                      setState(() => randomNavigationColor = color);
                      changeNavigationColor(color);
                    },
                    child: Text(
                      'Random color',
                      style: TextStyle(
                        color: useWhiteForeground(randomNavigationColor)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
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
