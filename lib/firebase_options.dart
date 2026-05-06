// PLACEHOLDER — Replace by running: flutterfire configure
// Or manually copy values from Firebase Console → Project Settings → Your apps
// flutterfire CLI: dart pub global activate flutterfire_cli && flutterfire configure
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions not configured for: $defaultTargetPlatform',
        );
    }
  }

  // TODO: Replace all 'REPLACE_ME' values with real Firebase config
  static const android = FirebaseOptions(
    apiKey: 'REPLACE_ME',
    appId: 'REPLACE_ME',
    messagingSenderId: 'REPLACE_ME',
    projectId: 'ojas-healing-prod',
    storageBucket: 'ojas-healing-prod.firebasestorage.app',
  );

  static const ios = FirebaseOptions(
    apiKey: 'REPLACE_ME',
    appId: 'REPLACE_ME',
    messagingSenderId: 'REPLACE_ME',
    projectId: 'ojas-healing-prod',
    storageBucket: 'ojas-healing-prod.firebasestorage.app',
    iosBundleId: 'com.ojashealing.app',
  );

  static const web = FirebaseOptions(
    apiKey: 'REPLACE_ME',
    appId: 'REPLACE_ME',
    messagingSenderId: 'REPLACE_ME',
    projectId: 'ojas-healing-prod',
    storageBucket: 'ojas-healing-prod.firebasestorage.app',
    authDomain: 'ojas-healing-prod.firebaseapp.com',
  );
}
