import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyD2pojdS2QYdFDxFOpRQgcCQyynW_1Bc24',
    appId: '1:151565721432:web:4e0582873081e2bb06cf2d',
    messagingSenderId: '151565721432',
    projectId: 'registromascotas-ade60',
    authDomain: 'registromascotas-ade60.firebaseapp.com',
    storageBucket: 'registromascotas-ade60.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABXP_AWTEL7eZVOi0uPtL28ulBVH7CYF0',
    appId: '1:151565721432:android:8688b97dcf9870d006cf2d',
    messagingSenderId: '151565721432',
    projectId: 'registromascotas-ade60',
    storageBucket: 'registromascotas-ade60.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCylurRsedx9lfr0szv_LKmjaVyPSRZHsU',
    appId: '1:151565721432:ios:32224167a6e1a31906cf2d',
    messagingSenderId: '151565721432',
    projectId: 'registromascotas-ade60',
    storageBucket: 'registromascotas-ade60.firebasestorage.app',
    iosBundleId: 'com.example.mascotasApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCylurRsedx9lfr0szv_LKmjaVyPSRZHsU',
    appId: '1:151565721432:ios:32224167a6e1a31906cf2d',
    messagingSenderId: '151565721432',
    projectId: 'registromascotas-ade60',
    storageBucket: 'registromascotas-ade60.firebasestorage.app',
    iosBundleId: 'com.example.mascotasApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD2pojdS2QYdFDxFOpRQgcCQyynW_1Bc24',
    appId: '1:151565721432:web:97a5165b2d2850ad06cf2d',
    messagingSenderId: '151565721432',
    projectId: 'registromascotas-ade60',
    authDomain: 'registromascotas-ade60.firebaseapp.com',
    storageBucket: 'registromascotas-ade60.firebasestorage.app',
  );
}
