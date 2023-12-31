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
    apiKey: 'AIzaSyC1FGENbaoJw90GedeSepd5U9nXpzfvmsc',
    appId: '1:630735264605:web:071e90020a91e15c72a6b4',
    messagingSenderId: '630735264605',
    projectId: 'anselm-401702',
    authDomain: 'anselm-401702.firebaseapp.com',
    databaseURL: 'https://anselm-401702-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'anselm-401702.appspot.com',
    measurementId: 'G-Q45W0GZE2W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNOoyHM8Cl6UEUP4DLYIZ-a3kTlmV0rf8',
    appId: '1:630735264605:android:4e0c45215472aeb172a6b4',
    messagingSenderId: '630735264605',
    projectId: 'anselm-401702',
    databaseURL: 'https://anselm-401702-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'anselm-401702.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK9yTkMMbpNYZDE4GN6BeaO720OZz1TkM',
    appId: '1:630735264605:ios:384b38a4379c51f572a6b4',
    messagingSenderId: '630735264605',
    projectId: 'anselm-401702',
    databaseURL: 'https://anselm-401702-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'anselm-401702.appspot.com',
    iosClientId: '630735264605-mghctbfo6ecir54odag7f11mqvk4bpge.apps.googleusercontent.com',
    iosBundleId: 'com.example.anselm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAK9yTkMMbpNYZDE4GN6BeaO720OZz1TkM',
    appId: '1:630735264605:ios:763308b518182abb72a6b4',
    messagingSenderId: '630735264605',
    projectId: 'anselm-401702',
    databaseURL: 'https://anselm-401702-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'anselm-401702.appspot.com',
    iosClientId: '630735264605-jut53pa4sa82jhnjh24hmd8up1une0j7.apps.googleusercontent.com',
    iosBundleId: 'com.example.anselm.RunnerTests',
  );
}
