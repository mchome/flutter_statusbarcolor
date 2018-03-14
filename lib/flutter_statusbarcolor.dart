import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class FlutterStatusbarcolor {
  static const MethodChannel _channel =
      const MethodChannel('plugins.fuyumi.com/statusbar');

  static Future setStatusBarColor(Color color) =>
      _channel.invokeMethod('setstatusbarcolor', {'color': color.value});
  static Future setNavigationBarColor(Color color) =>
      _channel.invokeMethod('setnavigationbarcolor', {'color': color.value});
}
