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
    apiKey: 'AIzaSyAPLSlJUemefDe5noxoaEq_Ca7oweOEDeM',
    appId: '1:235854596711:web:259d8a13e24aebcabc22c2',
    messagingSenderId: '235854596711',
    projectId: 'my-library-app-1a1f0',
    authDomain: 'my-library-app-1a1f0.firebaseapp.com',
    storageBucket: 'my-library-app-1a1f0.firebasestorage.app',
    measurementId: 'G-7NX3BQG38N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAx_fYUDl8JQrijJy94X7l0IEqA_YBpjGY',
    appId: '1:235854596711:android:88825fe35cf91186bc22c2',
    messagingSenderId: '235854596711',
    projectId: 'my-library-app-1a1f0',
    storageBucket: 'my-library-app-1a1f0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKVOR4DpjWfj3nsLXF8l46GWc7mzsCd0s',
    appId: '1:235854596711:ios:319d167ef8e67287bc22c2',
    messagingSenderId: '235854596711',
    projectId: 'my-library-app-1a1f0',
    storageBucket: 'my-library-app-1a1f0.firebasestorage.app',
    iosBundleId: 'com.example.mylibrary_app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKVOR4DpjWfj3nsLXF8l46GWc7mzsCd0s',
    appId: '1:235854596711:ios:319d167ef8e67287bc22c2',
    messagingSenderId: '235854596711',
    projectId: 'my-library-app-1a1f0',
    storageBucket: 'my-library-app-1a1f0.firebasestorage.app',
    iosBundleId: 'com.example.mylibrary_app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAPLSlJUemefDe5noxoaEq_Ca7oweOEDeM',
    appId: '1:235854596711:web:bdc3c79b6ccada35bc22c2',
    messagingSenderId: '235854596711',
    projectId: 'my-library-app-1a1f0',
    authDomain: 'my-library-app-1a1f0.firebaseapp.com',
    storageBucket: 'my-library-app-1a1f0.firebasestorage.app',
    measurementId: 'G-FKB2M6NQ02',
  );

}