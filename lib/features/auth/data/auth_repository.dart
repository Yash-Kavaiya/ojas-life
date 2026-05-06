import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/providers/firebase_providers.dart';
import '../domain/models/app_user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider));
});

class AuthRepository {
  AuthRepository(this._auth) : _googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  /// Streams the currently authenticated [AppUser], or null when signed out.
  Stream<AppUser?> watchCurrentUser() {
    return _auth.authStateChanges().map(
      (user) => user == null ? null : _toAppUser(user),
    );
  }

  /// Signs in via Google OAuth. Throws on cancellation or error.
  Future<AppUser> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign-in cancelled');

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final result = await _auth.signInWithCredential(credential);
    return _toAppUser(result.user!);
  }

  /// Signs in anonymously — used after the phone registration form
  /// so the router's auth guard is satisfied without OTP.
  Future<AppUser> signInAnonymously() async {
    final result = await _auth.signInAnonymously();
    return _toAppUser(result.user!);
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  AppUser _toAppUser(User user) => AppUser(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL,
        isAnonymous: user.isAnonymous,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
      );
}
