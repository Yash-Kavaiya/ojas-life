import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/auth_repository.dart';
import '../../domain/models/app_user.dart';

// ---------------------------------------------------------------------------
// Current user stream (AppUser domain model)
// ---------------------------------------------------------------------------

final currentUserProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authRepositoryProvider).watchCurrentUser();
});

// ---------------------------------------------------------------------------
// Google Sign-In
// ---------------------------------------------------------------------------

enum _SignInStatus { idle, loading, error }

class _SignInState {
  const _SignInState({
    this.status = _SignInStatus.idle,
    this.errorMessage,
  });
  final _SignInStatus status;
  final String? errorMessage;

  bool get isLoading => status == _SignInStatus.loading;
  String? get error => status == _SignInStatus.error ? errorMessage : null;

  _SignInState copyWith({_SignInStatus? status, String? errorMessage}) =>
      _SignInState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class GoogleSignInNotifier extends StateNotifier<_SignInState> {
  GoogleSignInNotifier(this._repo) : super(const _SignInState());

  final AuthRepository _repo;

  Future<void> signIn() async {
    state = state.copyWith(status: _SignInStatus.loading, errorMessage: null);
    try {
      await _repo.signInWithGoogle();
      state = const _SignInState(); // success — router redirect takes over
    } catch (e) {
      state = state.copyWith(
        status: _SignInStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}

final googleSignInProvider =
    StateNotifierProvider.autoDispose<GoogleSignInNotifier, _SignInState>(
  (ref) => GoogleSignInNotifier(ref.watch(authRepositoryProvider)),
);

// ---------------------------------------------------------------------------
// Registration data (collected before OTP verification)
// ---------------------------------------------------------------------------

class RegistrationData {
  const RegistrationData({
    this.name = '',
    this.gender = '',
    this.city = '',
  });

  final String name;
  final String gender;
  final String city;

  RegistrationData copyWith({String? name, String? gender, String? city}) =>
      RegistrationData(
        name: name ?? this.name,
        gender: gender ?? this.gender,
        city: city ?? this.city,
      );
}

final registrationDataProvider =
    StateProvider<RegistrationData>((ref) => const RegistrationData());

// ---------------------------------------------------------------------------
// Phone registration (no OTP — signs in anonymously after form submit)
// ---------------------------------------------------------------------------

class PhoneRegistrationNotifier
    extends StateNotifier<AsyncValue<void>> {
  PhoneRegistrationNotifier(this._repo) : super(const AsyncValue.data(null));

  final AuthRepository _repo;

  Future<void> register() async {
    state = const AsyncValue.loading();
    try {
      await _repo.signInAnonymously();
      state = const AsyncValue.data(null);
      // Router detects auth state change and redirects to home automatically
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final phoneRegistrationProvider = StateNotifierProvider.autoDispose<
    PhoneRegistrationNotifier, AsyncValue<void>>(
  (ref) => PhoneRegistrationNotifier(ref.watch(authRepositoryProvider)),
);
