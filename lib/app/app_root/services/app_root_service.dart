import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../auth/__.dart';
import '../misc/firebase_options.dart';

@lazySingleton
class AppRootService {
  final AuthService _authService;
  bool isConfigured = false;

  AppRootService(this._authService);

  Future<void> configureApp() async {
    if (isConfigured) {
      return;
    }
    isConfigured = true;
    await Firebase.initializeApp(
      name: 'smart-8ball',
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(!kDebugMode);

    await _authService.initAppAuthState();
    print('AppRootService.configureApp()');
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
