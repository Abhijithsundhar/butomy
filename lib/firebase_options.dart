// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBD0o0xxADdsLJ43AB3hiTg6g_KYfI5hyI',
    appId: '1:679026924744:web:876f043fe8931cf91259fd',
    messagingSenderId: '679026924744',
    projectId: 'salman-43f5b',
    authDomain: 'salman-43f5b.firebaseapp.com',
    storageBucket: 'salman-43f5b.appspot.com',
    measurementId: 'G-B6SGYRDN3B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAP9x-oWJ3d1Wr5ouqB7AARMH6HJNiCPTg',
    appId: '1:679026924744:android:98f314b09475d2061259fd',
    messagingSenderId: '679026924744',
    projectId: 'salman-43f5b',
    storageBucket: 'salman-43f5b.appspot.com',
  );
}
