import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Color _randomStatusColor = Colors.black;
  Color _randomNavigationColor = Colors.black;

  bool _useWhiteStatusBarForeground;
  bool _useWhiteNavigationBarForeground;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_useWhiteStatusBarForeground != null)
        FlutterStatusbarcolor.setStatusBarWhiteForeground(
            _useWhiteStatusBarForeground);
      if (_useWhiteNavigationBarForeground != null)
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(
            _useWhiteNavigationBarForeground);
    }
    super.didChangeAppLifecycleState(state);
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
        _useWhiteStatusBarForeground = true;
        _useWhiteNavigationBarForeground = true;
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
        _useWhiteStatusBarForeground = false;
        _useWhiteNavigationBarForeground = false;
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  changeNavigationColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(color, animate: true);
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
                  Builder(builder: (BuildContext context) {
                    return FlatButton(
                      onPressed: () => FlutterStatusbarcolor.getStatusBarColor()
                          .then((Color color) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(color.toString()),
                          backgroundColor: color,
                          duration: const Duration(milliseconds: 200),
                        ));
                      }),
                      child: Text(
                        'Show Statusbar Color',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    );
                  }),
                  Padding(padding: const EdgeInsets.all(10.0)),
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
                        FlutterStatusbarcolor.setStatusBarWhiteForeground(true)
                            .then((_) => _useWhiteStatusBarForeground = true),
                    child: Text(
                      'light foreground',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () =>
                        FlutterStatusbarcolor.setStatusBarWhiteForeground(false)
                            .then((_) => _useWhiteStatusBarForeground = false),
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
                      setState(() => _randomStatusColor = color);
                    },
                    child: Text(
                      'Random color',
                      style: TextStyle(
                        color: useWhiteForeground(_randomStatusColor)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    color: _randomStatusColor,
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Builder(builder: (BuildContext context) {
                    return FlatButton(
                      onPressed: () =>
                          FlutterStatusbarcolor.getNavigationBarColor()
                              .then((Color color) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(color.toString()),
                          backgroundColor: color,
                          duration: const Duration(milliseconds: 200),
                        ));
                      }),
                      child: Text(
                        'Show Navigationbar Color',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                    );
                  }),
                  Padding(padding: const EdgeInsets.all(10.0)),
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
                    onPressed: () => FlutterStatusbarcolor
                            .setNavigationBarWhiteForeground(true)
                        .then((_) => _useWhiteNavigationBarForeground = true),
                    child: Text(
                      'light foreground',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                  Padding(padding: const EdgeInsets.all(10.0)),
                  FlatButton(
                    onPressed: () => FlutterStatusbarcolor
                            .setNavigationBarWhiteForeground(false)
                        .then((_) => _useWhiteNavigationBarForeground = false),
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
                      setState(() => _randomNavigationColor = color);
                      changeNavigationColor(color);
                    },
                    child: Text(
                      'Random color',
                      style: TextStyle(
                        color: useWhiteForeground(_randomNavigationColor)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    color: _randomNavigationColor,
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
