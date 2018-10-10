# flutter_statusbarcolor

[![pub package](https://img.shields.io/pub/v/flutter_statusbarcolor.svg)](https://pub.dartlang.org/packages/flutter_statusbarcolor)

A package can help you to change your flutter app's statusbar's color or navigationbar's color programmatically.

## Getting Started

### Installation

Add this to your pubspec.yaml (or create it):

```yaml
dependencies:
  flutter_statusbarcolor: any
```

Then run the flutter tooling:

```bash
flutter packages get
```

### Example

```dart
// change the status bar color to material color [green-400].
try {
  await FlutterStatusbarcolor.setStatusBarColor(Colors.green[400]);
  if (useWhiteForeground(Colors.green[400])) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  }
} on PlatformException catch (e) {
  print(e);
}

// change the navigation bar color to material color [orange-200].
try {
  await FlutterStatusbarcolor.setNavigationBarColor(Colors.orange[200]);
  if (useWhiteForeground(Colors.orange[200]) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  }
} on PlatformException catch (e) {
  print(e);
}
```

![preview](https://user-images.githubusercontent.com/7392658/46727295-d5528480-ccb2-11e8-9bbf-e47e40ee36c3.png)

Details in [example/](https://github.com/mchome/flutter_statusbarcolor/tree/master/example) folder.

## Api level minimum requirement

- android
  - setStatusBarColor (5.0)
  - setStatusBarWhiteForeground (6.0)
  - setNavigationBarColor (5.0)
  - setNavigationBarWhiteForeground (8.0)

- ios
  - setStatusBarColor (7+)
  - setStatusBarWhiteForeground (7+)

## Note that

- If ios build does not work, please send issues or pull requests.
