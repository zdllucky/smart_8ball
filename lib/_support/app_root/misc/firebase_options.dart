// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1UI-2OGct5p96bS25sAs2pdeubxlD8vM',
    appId: '1:819882374666:android:ba497ee6e6a50bfe8591f3',
    messagingSenderId: '819882374666',
    projectId: 'smart-8ball',
    databaseURL: 'https://smart-8ball-default-rtdb.firebaseio.com',
    storageBucket: 'smart-8ball.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0PZBn5MF9QSOQJ2xqiqnmBdnVqh3fxhM',
    appId: '1:819882374666:ios:c3d8cc61b808e28a8591f3',
    messagingSenderId: '819882374666',
    projectId: 'smart-8ball',
    databaseURL: 'https://smart-8ball-default-rtdb.firebaseio.com',
    storageBucket: 'smart-8ball.appspot.com',
    iosClientId:
        '819882374666-k1j472plgle392ddglkauidanudm1okr.apps.googleusercontent.com',
    iosBundleId: 'quest.ponder8.ponder8',
  );
}
