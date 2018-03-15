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
} on PlatformException catch (e) {
  print(e);
}

// change the navigation bar color to material color [orange-200].
try {
  await FlutterStatusbarcolor.setNavigationBarColor(Colors.orange[200]);
} on PlatformException catch (e) {
  print(e);
}
```

Details in [example/](https://github.com/mchome/flutter_statusbarcolor/tree/master/example) folder.

## Note that

- Android build api which below 21(Lollipop) does not work.
