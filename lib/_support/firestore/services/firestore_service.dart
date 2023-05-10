import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_8ball/_support/app_root/__.dart';

@lazySingleton
class FirestoreService {
  FirebaseFirestore get provider => FirebaseFirestore.instance;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    if (Mode.isEmulator) {
      provider.useFirestoreEmulator(
          String.fromEnvironment('EMULATOR_REMOTE_HOST'), 8080);
      await provider.enableNetwork();
    }
    provider.settings = const Settings(persistenceEnabled: false);
  }
}
