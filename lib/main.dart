import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_8ball/app/router.dart';

import 'firebase_options.dart';
import 'infrastructure/di/injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fAuth = FirebaseAuth.instance;

  if (kDebugMode) await fAuth.useAuthEmulator('192.168.31.149', 9099);

  await configureDependencies();

  if (fAuth.currentUser == null || !fAuth.currentUser!.emailVerified) {
    await fAuth.signInAnonymously();
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
