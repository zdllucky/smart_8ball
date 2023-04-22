import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_support/auth/__.dart';
import 'package:smart_8ball/_support/router/__.dart';
import 'package:smart_8ball/_widgets/tries/__.dart';

import '../services/app_root_service.dart';

const theme = CupertinoThemeData(
    brightness: Brightness.dark, primaryColor: CupertinoColors.systemOrange);

Future<Widget> appRootView() async {
  Paint.enableDithering = true;

  await AppRootService().configureApp();

  return CupertinoApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) =>
          AuthProvider(child: TriesAvailableProvider(child: child)),
      theme: theme);
}
