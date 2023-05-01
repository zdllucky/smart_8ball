import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../models/anonymous_user_link_model.dart';
import '../services/firestore_service.dart';

@lazySingleton
class AnonymousUserLinksRepo {
  late final FirebaseFirestore _fs;
  late final CollectionReference<AnonymousUserLinkModel> _aulRef;
  static const _aul = 'anonymousUserLinks';
  static const _ul = 'linksTo';
  final _getOptions = const GetOptions(source: Source.server);

  AnonymousUserLinksRepo(FirestoreService firestoreService) {
    _fs = firestoreService.provider;

    _aulRef = _fs.collection(_aul).withConverter(
          fromFirestore: (snapshot, _) =>
              AnonymousUserLinkModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  Future<void> linkAnonymousUserToDevice({
    required String deviceId,
    required String userId,
  }) async {
    final doc = _aulRef.doc(deviceId).linksTo.doc(userId);

    try {
      final ds = await doc.get(_getOptions);

      if (ds.exists) return;
    } finally {
      try {
        await doc.set(UserLink.empty());
      } catch (e) {
        debugPrint('Error linking user to device: $e');
      }
    }
  }

  Future<void> registerDeviceId(String deviceId) async {
    final doc = _aulRef.doc(deviceId);

    try {
      final ds = await doc.get(_getOptions);

      if (ds.exists) return;
    } finally {}

    try {
      await doc.set(AnonymousUserLinkModel.empty());
    } catch (e) {
      debugPrint('Error registering device id: $e');
    }
  }
}

extension on DocumentReference<AnonymousUserLinkModel> {
  CollectionReference<UserLink> get linksTo =>
      collection('linksTo').withConverter(
        fromFirestore: (snapshot, _) => UserLink.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson(),
      );
}
