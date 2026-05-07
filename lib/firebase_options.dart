import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) throw UnsupportedError('Web platform not configured.');
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions not configured for: $defaultTargetPlatform',
        );
    }
  }

  static const android = FirebaseOptions(
    apiKey: 'AIzaSyCdadFzJTmhe_czkk4IIFHfueYahIKRYeo',
    appId: '1:381861530396:android:6935ec5190ebfff26948d9',
    messagingSenderId: '381861530396',
    projectId: 'ojas-life-moblie-app',
    storageBucket: 'ojas-life-moblie-app.firebasestorage.app',
  );
}
