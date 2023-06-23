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
    apiKey: 'AIzaSyDuEpV_VpsX6-y4Vegi1IxQwqx-O_4H-RA',
    appId: '1:959910779907:web:3f3e72b25d33cefecc4236',
    messagingSenderId: '959910779907',
    projectId: 'my-app-futter-web',
    authDomain: 'my-app-futter-web.firebaseapp.com',
    storageBucket: 'my-app-futter-web.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3QhrUvD5YItMJxoZU8zhF6t4yctoKXqc',
    appId: '1:959910779907:android:5edb0055108edda6cc4236',
    messagingSenderId: '959910779907',
    projectId: 'my-app-futter-web',
    storageBucket: 'my-app-futter-web.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDnSMUickjq6YLnR5xl_k5BLIaHbQwlNp0',
    appId: '1:959910779907:ios:f7a4b48c79e7ae21cc4236',
    messagingSenderId: '959910779907',
    projectId: 'my-app-futter-web',
    storageBucket: 'my-app-futter-web.appspot.com',
    iosClientId: '959910779907-sjoabc1lu0ip4tla6145936f43l2nvme.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminDashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDnSMUickjq6YLnR5xl_k5BLIaHbQwlNp0',
    appId: '1:959910779907:ios:f7a4b48c79e7ae21cc4236',
    messagingSenderId: '959910779907',
    projectId: 'my-app-futter-web',
    storageBucket: 'my-app-futter-web.appspot.com',
    iosClientId: '959910779907-sjoabc1lu0ip4tla6145936f43l2nvme.apps.googleusercontent.com',
    iosBundleId: 'com.example.adminDashboard',
  );
}