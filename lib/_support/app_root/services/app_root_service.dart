import 'dart:isolate';

import 'package:firebase_core/firebase_core.dart';
import "package:firebase_crashlytics/firebase_crashlytics.dart";
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/analytics/__.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/di/__.dart';
import 'package:smart_8ball/_support/router/__.dart';
import 'package:smart_8ball/_widgets/tries/__.dart';

import '../misc/firebase_options.dart';
import '../misc/theme.dart';

class AppRootService {
  late final AuthService _authService;
  late final RouterService _routerService;
  late final CrashlyticsService _crashlyticsService;
  bool isConfigured = false;

  @PostConstruct(preResolve: true)
  Future<void> configureApp() async {
    /// Flutter hot restart within app
    if (isConfigured) {
      return;
    }
    isConfigured = true;

    debugPrint('Configuring app in ${const Mode()} mode...');

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await configureDependencies();

    if (!Mode.isEmulator) {
      get<AnalyticsService>();

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      Isolate.current.addErrorListener(RawReceivePort((pair) async {
        final List<dynamic> errorAndStacktrace = pair;
        await FirebaseCrashlytics.instance.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last,
          fatal: true,
        );
      }).sendPort);
    }

    _crashlyticsService = get();

    _crashlyticsService
      ..logBasicErrors()
      ..logAsyncStreamErrors()
      ..logPlatformErrors();

    _authService = get();
    _routerService = get();

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: Mode.isEmulator
          ? const Duration(minutes: 3)
          : const Duration(hours: 1),
    ));

    await remoteConfig.fetchAndActivate();

    await _authService.initAppAuthState();
  }

  Future<void> resetApp(BuildContext? context) async {
    if (context != null) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
    try {
      await WidgetsFlutterBinding.ensureInitialized().reassembleApplication();
    } finally {
      await _authService.initAppAuthState();
    }
  }

  Future<Widget> appRootView() async {
    Paint.enableDithering = true;

    return CupertinoApp.router(
        routerConfig: _routerService.router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) =>
            AuthProvider(child: TriesAvailableProvider(child: child)),
        theme: theme);
  }
}
