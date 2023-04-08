import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AnonymousUserLinksRepo {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;
  final _aul = 'anonymousUserLinks';

  Future<void> linkAnonymousUserToDevice(
      {required String deviceId, required String userId}) async {
    try {
      (await _firestore.collection(_aul).doc(deviceId).get())['linksTo'];
    } catch (e) {
      await _firestore.collection(_aul).doc(deviceId).set({
        'linksTo': FieldValue.arrayUnion([userId])
      }, SetOptions(merge: true));
    }
  }
}
