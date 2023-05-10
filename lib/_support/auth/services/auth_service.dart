import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/analytics/__.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/auth/__.dart';

import '../../firestore/__.dart';

@lazySingleton
class AuthService {
  final CrashlyticsService _crashlyticsService;
  final AnalyticsService _analyticsService;
  final AnonymousUserLinksRepo _anonymousUserLinksRepo;
  final DeviceMetadataService _deviceMetadataService;
  bool _isInitialized = false;

  FirebaseAuth get provider => FirebaseAuth.instance;
  User? get user => provider.currentUser;

  AuthService(
    this._anonymousUserLinksRepo,
    this._analyticsService,
    this._crashlyticsService,
    this._deviceMetadataService,
  );

  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Connect to the firebase auth emulator if in debug mode
    if (Mode.isEmulator) {
      await provider.useAuthEmulator(
          const String.fromEnvironment('EMULATOR_REMOTE_HOST'), 9099);
    }

    // If the user is not signed in, sign them in anonymously
    await signInAnonymously(resetSession: kDebugMode);
  }

  Future<void> signInAnonymously({bool resetSession = false}) async {
    final dId = _deviceMetadataService.deviceId;
    if (resetSession) await provider.signOut();
    await provider.signInAnonymously();

    final userId = provider.currentUser!.uid;

    // Set the user id for analytics
    if (!Mode.isEmulator) {
      _analyticsService
        ..user = userId
        ..userParams = {"type": "anonymous", "deviceId": dId};

      _crashlyticsService.userIdentifier = userId;
    }

    debugPrint('Linking anonymous user $userId to device $dId...');
    await _anonymousUserLinksRepo.registerDeviceId(dId);
    await _anonymousUserLinksRepo.linkAnonymousUserToDevice(
      deviceId: dId,
      userId: provider.currentUser!.uid,
    );
  }
}
