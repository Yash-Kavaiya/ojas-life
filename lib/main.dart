import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';
import 'core/services/storage_service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local storage — must be ready before ProviderScope initialises providers
  await StorageService.init();

  // Firebase — requires firebase_options.dart to be populated (Step 4)
  // Run `flutterfire configure` or paste values from Firebase Console
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: OjasApp()));
}
