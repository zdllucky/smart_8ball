import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/di/__.dart';

import '../misc/firebase_options.dart';

class AppRootService {
  late final AuthService _authService;
  bool isConfigured = false;

  @PostConstruct(preResolve: true)
  Future<void> configureApp() async {
    /// Flutter hot restart within app
    if (isConfigured) {
      return;
    }
    isConfigured = true;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await configureDependencies();

    // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);

    if (kDebugMode) {
      FirebaseFunctions.instance.useFunctionsEmulator('192.168.31.149', 9099);
    }

    _authService = get();

    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval:
          kDebugMode ? const Duration(minutes: 3) : const Duration(hours: 1),
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
}
