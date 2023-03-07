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
    apiKey: 'AIzaSyAP0bduWg5o3sYdBLgPcpriCLPkLWzZaTY',
    appId: '1:570032156758:web:f3d88dd61e1f4bea8f4bf7',
    messagingSenderId: '570032156758',
    projectId: 'rideon-dc993',
    authDomain: 'rideon-dc993.firebaseapp.com',
    storageBucket: 'rideon-dc993.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKBx4M0wb7_JXH3GggyPbgC8py7qni3Hs',
    appId: '1:570032156758:android:0ddc569612820d448f4bf7',
    messagingSenderId: '570032156758',
    projectId: 'rideon-dc993',
    storageBucket: 'rideon-dc993.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDoAv8f3jzFJh3xQjMzWSRWh4WooJOsZxk',
    appId: '1:570032156758:ios:67f9ad026a8d41be8f4bf7',
    messagingSenderId: '570032156758',
    projectId: 'rideon-dc993',
    storageBucket: 'rideon-dc993.appspot.com',
    iosClientId:
        '570032156758-ajcgdg1ue5o1qsp7bbad6a9bsvg34ti4.apps.googleusercontent.com',
    iosBundleId: 'com.example.cyclingRoutes',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDoAv8f3jzFJh3xQjMzWSRWh4WooJOsZxk',
    appId: '1:570032156758:ios:67f9ad026a8d41be8f4bf7',
    messagingSenderId: '570032156758',
    projectId: 'rideon-dc993',
    storageBucket: 'rideon-dc993.appspot.com',
    iosClientId:
        '570032156758-ajcgdg1ue5o1qsp7bbad6a9bsvg34ti4.apps.googleusercontent.com',
    iosBundleId: 'com.example.cyclingRoutes',
  );
}
