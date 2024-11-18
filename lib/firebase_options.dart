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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBAHMHuSC75er79GTJq9wfVijaW84I61wE',
    appId: '1:192091521327:web:7a13f11a1f8565429121da',
    messagingSenderId: '192091521327',
    projectId: 'dynamic-ui-1cd04',
    authDomain: 'dynamic-ui-1cd04.firebaseapp.com',
    storageBucket: 'dynamic-ui-1cd04.firebasestorage.app',
    measurementId: 'G-PZQ926KRKG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRQ-L5m-wKvqB4YsKYzflL6rxmj0RzV1M',
    appId: '1:192091521327:android:05d96c60127029099121da',
    messagingSenderId: '192091521327',
    projectId: 'dynamic-ui-1cd04',
    storageBucket: 'dynamic-ui-1cd04.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBM-LchRNugqwxfMvtka2lxMnLatXTb5g',
    appId: '1:192091521327:ios:ffd6f75352413b7d9121da',
    messagingSenderId: '192091521327',
    projectId: 'dynamic-ui-1cd04',
    storageBucket: 'dynamic-ui-1cd04.firebasestorage.app',
    iosBundleId: 'com.example.dynamicUi',
  );
}
