/// Call platform code to get/set status bar or navigation bar
/// background color and foreground brightness.

import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class FlutterStatusbarcolor {
  static const MethodChannel _channel =
      const MethodChannel('plugins.fuyumi.com/statusbar');

  /// Get the status bar background color.
  static Future<Color> getStatusBarColor() =>
      _channel.invokeMethod('getstatusbarcolor').then((dynamic value) {
        return value == null ? null : Color(value);
      });

  /// Set the status bar background color.
  static Future<void> setStatusBarColor(
    Color color, {
    bool animate = false,
  }) =>
      _channel.invokeMethod('setstatusbarcolor', {
        'color': color.value,
        'animate': animate,
      });

  /// Set the status bar foreground brightness.
  /// Set to true, the color of the text and icon
  /// will be white, otherwise black.
  static Future<void> setStatusBarWhiteForeground(bool useWhiteForeground) =>
      _channel.invokeMethod('setstatusbarwhiteforeground', {
        'whiteForeground': useWhiteForeground,
      });

  /// Android only
  ///
  /// Get the navigation bar background color.
  static Future<Color> getNavigationBarColor() =>
      _channel.invokeMethod('getnavigationbarcolor').then((dynamic value) {
        return value == null ? null : Color(value);
      });

  /// Android only
  ///
  /// Set the navigation bar background color.
  /// The alpha of the input color will be ignoreed
  /// because of flutter's android layout.
  static Future<void> setNavigationBarColor(
    Color color, {
    bool animate = false,
  }) =>
      _channel.invokeMethod('setnavigationbarcolor', {
        'color': color.value,
        'animate': animate,
      });

  /// Android only
  ///
  /// Set the navigation bar foreground brightness.
  /// Set to true, the color of the text and icon
  /// will be white, otherwise black.
  static Future<void> setNavigationBarWhiteForeground(
          bool useWhiteForeground) =>
      _channel.invokeMethod('setnavigationbarwhiteforeground', {
        'whiteForeground': useWhiteForeground,
      });
}

/// Help you choosing the black or white foreground color
/// to improve the foreground visible.
bool useWhiteForeground(Color backgroundColor) =>
    1.05 / (backgroundColor.computeLuminance() + 0.05) > 4.5;
