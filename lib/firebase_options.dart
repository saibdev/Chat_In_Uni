// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
///
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
    apiKey: 'AIzaSyBh9MPmP-PfNNl8INDyJcOAPC2bbySOzAo',
    appId: '1:1007774413971:web:1a8485af55cdf2d7bbc966',
    messagingSenderId: '1007774413971',
    projectId: 'chatinuni-d900d',
    authDomain: 'chatinuni-d900d.firebaseapp.com',
    databaseURL: 'https://chatinuni-d900d.firebaseio.com',
    storageBucket: 'chatinuni-d900d.appspot.com',
    measurementId: 'G-QVEWPT7T91',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBfzMTKN8XBeVGKWNqoqcJ-I53USszILB4',
    appId: '1:1007774413971:android:170cbe0dd3be727bbbc966',
    messagingSenderId: '1007774413971',
    projectId: 'chatinuni-d900d',
    databaseURL: 'https://chatinuni-d900d.firebaseio.com',
    storageBucket: 'chatinuni-d900d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCIq6J-J8iSYIIunOAL2SxADsGV79p_LTM',
    appId: '1:1007774413971:ios:bc5d4f1135599288bbc966',
    messagingSenderId: '1007774413971',
    projectId: 'chatinuni-d900d',
    databaseURL: 'https://chatinuni-d900d.firebaseio.com',
    storageBucket: 'chatinuni-d900d.appspot.com',
    iosClientId:
        '1007774413971-kc2pshjjb016npit6una8g6uctr889mj.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatinunii',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCIq6J-J8iSYIIunOAL2SxADsGV79p_LTM',
    appId: '1:1007774413971:ios:bc5d4f1135599288bbc966',
    messagingSenderId: '1007774413971',
    projectId: 'chatinuni-d900d',
    databaseURL: 'https://chatinuni-d900d.firebaseio.com',
    storageBucket: 'chatinuni-d900d.appspot.com',
    iosClientId:
        '1007774413971-kc2pshjjb016npit6una8g6uctr889mj.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatinunii',
  );
}
