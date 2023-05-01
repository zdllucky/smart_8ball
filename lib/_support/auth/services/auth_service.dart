import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/app_root/__.dart';

import '../../firestore/__.dart';

@lazySingleton
class AuthService {
  AuthService(this._anonymousUserLinksRepo);

  final AnonymousUserLinksRepo _anonymousUserLinksRepo;
  FirebaseAuth get provider => FirebaseAuth.instance;
  User? get user => FirebaseAuth.instance.currentUser;
  FirebaseAnalytics get _analytics => FirebaseAnalytics.instance;
  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;
  String? _deviceId;

  String? get deviceId => _deviceId;

  Future<void> initAppAuthState({bool includeAnalytics = true}) async {
    // Connect to the firebase auth emulator if in debug mode
    if (Mode.isEmulator) await provider.useAuthEmulator('192.168.31.149', 9099);
    _deviceId = await _getDeviceId();

    // If the user is not signed in, sign them in anonymously
    await signInAnonymously(resetSession: kDebugMode);
  }

  Future<void> signInAnonymously({bool resetSession = true}) async {
    final dId = await _getDeviceId();
    if (resetSession) await provider.signOut();
    await provider.signInAnonymously();

    final userId = provider.currentUser!.uid;

    // Set the user id for analytics
    if (!Mode.isEmulator) {
      _analytics.setUserId(id: userId);
      crashlytics.setUserIdentifier(userId);
    }

    // TODO: Move this to a cloud function

    debugPrint('Linking anonymous user $userId to device $dId...');
    await _anonymousUserLinksRepo.registerDeviceId(dId);
    await _anonymousUserLinksRepo.linkAnonymousUserToDevice(
        deviceId: dId, userId: provider.currentUser!.uid);

    _deviceId = dId;
  }

  String _generateRandomString(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  Future<String> _getDeviceId() async {
    String? deviceId;
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.fingerprint;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    return deviceId ?? _generateRandomString(32);
  }
}
