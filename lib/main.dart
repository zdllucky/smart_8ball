import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_support/app_root/__.dart';
import 'package:smart_8ball/_support/di/__.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppRootService.initFirebase();

  final AppRootService appRootService = (await configureDependencies())();

  await appRootService.configureApp();

  runApp(await appRootService.appRootView());
}
