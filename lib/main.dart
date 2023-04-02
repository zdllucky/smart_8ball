import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'app/app_root/__.dart';
import 'infrastructure/di/injections.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(await appRootView());
}
