import 'package:flutter/cupertino.dart';

import '../../../../../_support/di/injections.dart';
import '../../auth/__.dart';
import '../../router/__.dart';
import '../../tries/__.dart';
import '../services/app_root_service.dart';

const theme = CupertinoThemeData(
    brightness: Brightness.dark, primaryColor: CupertinoColors.systemOrange);

Future<Widget> appRootView() async {
  Paint.enableDithering = true;

  await get<AppRootService>().configureApp();

  return CupertinoApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) =>
          AuthProvider(child: TriesAvailableProvider(child: child)),
      theme: theme);
}
