import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:smart_8ball/_support/app_root/__.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(await appRootView());
}
