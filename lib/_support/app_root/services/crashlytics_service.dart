import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CrashlyticsService {
  FirebaseCrashlytics get _provider => FirebaseCrashlytics.instance;

  set userIdentifier(String userIdentifier) =>
      _provider.setUserIdentifier(userIdentifier);

  void logBasicErrors() =>
      FlutterError.onError = _provider.recordFlutterFatalError;

  void logAsyncStreamErrors() =>
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

  void logPlatformErrors() =>
      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
          fatal: true,
        );
      }).sendPort);
}
