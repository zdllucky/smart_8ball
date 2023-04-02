import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  FirebaseAuth get provider => FirebaseAuth.instance;

  Future<void> initAppAuthState({bool includeAnalytics = true}) async {
    // Connect to the firebase auth emulator if in debug mode
    if (kDebugMode) await provider.useAuthEmulator('localhost', 9099);

    // If the user is not signed in, sign them in anonymously
    if (provider.currentUser == null) {
      try {
        await provider.signInAnonymously();
      } finally {}
    }

    // Set the user id for analytics
    if (includeAnalytics) {
      FirebaseAnalytics.instance.setUserId(id: provider.currentUser?.uid);
    }
  }
}
