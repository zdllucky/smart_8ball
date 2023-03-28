import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'app/router/__.dart';
import 'firebase_options.dart';
import 'infrastructure/di/injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fAuth = FirebaseAuth.instance;

  if (kDebugMode) await fAuth.useAuthEmulator('localhost', 9099);

  await configureDependencies();

  if (fAuth.currentUser == null || !fAuth.currentUser!.emailVerified) {
    try {
      await fAuth.signInAnonymously();
    } finally {}
  }

  runApp(CupertinoApp.router(
    routerConfig: appRouter,
    debugShowCheckedModeBanner: false,
    theme: const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.systemOrange,
    ),
  ));
}
