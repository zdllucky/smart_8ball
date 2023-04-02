import 'package:flutter/cupertino.dart';

import '../../../infrastructure/di/injections.dart';
import '../../auth/__.dart';
import '../../router/__.dart';
import '../services/app_root_service.dart';

const theme = CupertinoThemeData(
    brightness: Brightness.dark, primaryColor: CupertinoColors.systemOrange);

Future<Widget> appRootView() async {
  await get<AppRootService>().configureApp();

  return CupertinoApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => AuthProvider(child: child),
      theme: theme);
}
