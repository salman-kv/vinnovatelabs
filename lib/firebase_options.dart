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
    apiKey: 'AIzaSyBlf8FJqsp_o8zxZJrbHXohd-oWwfPfY20',
    appId: '1:116461696669:web:256ae9760a4134beb44674',
    messagingSenderId: '116461696669',
    projectId: 'vinnovate-abd21',
    authDomain: 'vinnovate-abd21.firebaseapp.com',
    storageBucket: 'vinnovate-abd21.appspot.com',
    measurementId: 'G-T596Y3HRNE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPA7iVKCivvgh6fzCm9uwFXQs6BOpLmWM',
    appId: '1:116461696669:android:97d26971e751ff8cb44674',
    messagingSenderId: '116461696669',
    projectId: 'vinnovate-abd21',
    storageBucket: 'vinnovate-abd21.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZZ6pqMGsUL5LiTtcPFkp-sPde9XPOsTw',
    appId: '1:116461696669:ios:d7392809b789cbfbb44674',
    messagingSenderId: '116461696669',
    projectId: 'vinnovate-abd21',
    storageBucket: 'vinnovate-abd21.appspot.com',
    iosBundleId: 'com.example.vinnovatelabzsalmankv',
  );

}