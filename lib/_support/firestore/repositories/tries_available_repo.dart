import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/tries_available_model.dart';

@lazySingleton
class TriesAvailableRepo {
  static FirebaseFirestore get _fs => FirebaseFirestore.instance;
  static const _ta = 'triesAvailable';
  final CollectionReference<TriesAvailableModel> _ref = _fs
      .collection(_ta)
      .withConverter(
          fromFirestore: (snapshot, _) =>
              TriesAvailableModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson());

  StreamSubscription<DocumentSnapshot<TriesAvailableModel>> Function(
      void Function(DocumentSnapshot<TriesAvailableModel> event)? onData,
      {bool? cancelOnError,
      void Function()? onDone,
      Function? onError}) subscribeToTriesAvailableDocument(
          String deviceOrUserId) =>
      _ref.doc(deviceOrUserId).snapshots().listen;
}
