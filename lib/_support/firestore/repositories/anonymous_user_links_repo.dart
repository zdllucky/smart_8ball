import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../models/anonymous_user_link_model.dart';
import '../services/firestore_service.dart';

@lazySingleton
class AnonymousUserLinksRepo {
  late final FirebaseFirestore _fs;
  late final CollectionReference<AnonymousUserLinkModel> _ref;
  static const _aul = 'anonymousUserLinks';
  final _getOptions = const GetOptions(source: Source.server);

  AnonymousUserLinksRepo(FirestoreService firestoreService) {
    _fs = firestoreService.provider;

    _ref = _fs.collection(_aul).withConverter(
        fromFirestore: (snapshot, _) =>
            AnonymousUserLinkModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());
  }

  Future<void> linkAnonymousUserToDevice({
    required String deviceId,
    required String userId,
  }) async {
    if (kDebugMode) {
      final res = await Dio().get('http://192.168.31.149:8080');
      debugPrint('res: ${res.data}');
    }
    try {
      await _ref.doc(deviceId).get(_getOptions);
    } catch (e) {
      try {
        await _ref.doc(deviceId).set(
              AnonymousUserLinkModel([userId]),
              SetOptions(mergeFields: ['linksTo']),
            );
      } catch (e) {
        debugPrint('Error linking anonymous user to device: $e');
      }
    }
  }
}
