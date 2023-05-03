import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/analytics/__.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/router/__.dart';
import 'package:smart_8ball/_widgets/tries/__.dart';

import '../misc/firebase_options.dart';
import '../misc/theme.dart';

@lazySingleton
class AppRootService {
  final AuthService _authService;
  final RouterService _routerService;
  final CrashlyticsService _crashlyticsService;
  final AnalyticsService _analyticsService;
  bool isConfigured = false;

  AppRootService(
    this._analyticsService,
    this._crashlyticsService,
    this._authService,
    this._routerService,
  );

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @PostConstruct(preResolve: true)
  Future<void> configureApp() async {
    /// Flutter hot restart within app
    if (isConfigured) return;
    isConfigured = true;

    debugPrint('Configuring app in ${const Mode()} mode...');

    _crashlyticsService
      ..logBasicErrors()
      ..logAsyncStreamErrors()
      ..logPlatformErrors();

    await _analyticsService.init();
    await _analyticsService.logAppOpen();

    await initRemoteConfig();

    await _authService.init();
  }

  Future<void> initRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: Mode.isEmulator
          ? const Duration(minutes: 3)
          : const Duration(hours: 1),
    ));

    await remoteConfig.fetchAndActivate();
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
