import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  FirebaseFirestore get provider => FirebaseFirestore.instance;

  FirestoreService();

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    debugPrint('FirestoreService.init()');
    if (kDebugMode) {
      FirebaseFirestore.instance.useFirestoreEmulator('192.168.31.149', 8080);
      await provider.enableNetwork();
    }
  }
}
