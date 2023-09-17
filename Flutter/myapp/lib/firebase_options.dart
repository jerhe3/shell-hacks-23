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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDr8NB7-2prnhoB7ElV0ZAyHEnmO9ezmak',
    appId: '1:48934607056:web:83d8b453b8df5e8807e6d5',
    messagingSenderId: '48934607056',
    projectId: 'firestore-example-two',
    authDomain: 'firestore-example-two.firebaseapp.com',
    storageBucket: 'firestore-example-two.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvwAAzWEgbxmO-xU8sp0b6IxVZpdRznIo',
    appId: '1:48934607056:android:8a267eeb4154fa0607e6d5',
    messagingSenderId: '48934607056',
    projectId: 'firestore-example-two',
    storageBucket: 'firestore-example-two.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEy01YHrpaSDza-4ZusAkzzYXCNT3ltYg',
    appId: '1:48934607056:ios:f6caa23a48789d5007e6d5',
    messagingSenderId: '48934607056',
    projectId: 'firestore-example-two',
    storageBucket: 'firestore-example-two.appspot.com',
    iosBundleId: 'com.shellypeople.planpilot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEy01YHrpaSDza-4ZusAkzzYXCNT3ltYg',
    appId: '1:48934607056:ios:f6caa23a48789d5007e6d5',
    messagingSenderId: '48934607056',
    projectId: 'firestore-example-two',
    storageBucket: 'firestore-example-two.appspot.com',
    iosBundleId: 'com.shellypeople.planpilot',
  );
}
