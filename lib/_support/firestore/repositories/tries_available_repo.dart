import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/tries_available_model.dart';
import '../services/firestore_service.dart';

@lazySingleton
class TriesAvailableRepo {
  late final FirebaseFirestore _fs;
  static const _ta = 'triesAvailable';
  late final CollectionReference<TriesAvailableModel> _ref;

  TriesAvailableRepo(FirestoreService firestoreService) {
    _fs = firestoreService.provider;

    _ref = _fs.collection(_ta).withConverter(
        fromFirestore: (snapshot, _) =>
            TriesAvailableModel.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());
  }

  StreamSubscription<DocumentSnapshot<TriesAvailableModel>> Function(
      void Function(DocumentSnapshot<TriesAvailableModel> event)? onData,
      {bool? cancelOnError,
      void Function()? onDone,
      Function? onError}) subscribeToTriesAvailableDocument(
          String deviceOrUserId) =>
      _ref.doc(deviceOrUserId).snapshots().listen;
}
