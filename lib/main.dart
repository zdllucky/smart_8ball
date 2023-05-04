import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/di/__.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await AppRootService.initFirebase();

  final AppRootService appRootService = (await configureDependencies())();

  await appRootService.configureApp();

  runApp(await appRootService.appRootView());
}
