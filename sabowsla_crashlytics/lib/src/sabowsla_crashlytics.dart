import 'package:flutter/foundation.dart';

SabowslaCrashlytics? _currentInstance;

class SabowslaCrashlytics {
  static SabowslaCrashlytics get instance {
    _currentInstance ??= SabowslaCrashlytics();
    return _currentInstance!;
  }

  void recordFlutterFatalError(FlutterErrorDetails details) {
    _currentInstance ??= SabowslaCrashlytics();
    _currentInstance!.recordFlutterFatalError(details);
  }

  void recordError(Object error, StackTrace stack, {bool fatal = false}) {
    _currentInstance ??= SabowslaCrashlytics();
    _currentInstance!.recordError(error, stack, fatal: fatal);
  }
}
