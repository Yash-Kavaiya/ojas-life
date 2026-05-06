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
// Phone / OTP auth
// ---------------------------------------------------------------------------

enum PhoneAuthStatus { idle, loading, codeSent, verifying, error }

class PhoneAuthState {
  const PhoneAuthState({
    this.status = PhoneAuthStatus.idle,
    this.phoneNumber,
    this.verificationId,
    this.errorMessage,
  });

  final PhoneAuthStatus status;
  final String? phoneNumber;
  final String? verificationId;
  final String? errorMessage;

  bool get isLoading =>
      status == PhoneAuthStatus.loading || status == PhoneAuthStatus.verifying;
  bool get isCodeSent => status == PhoneAuthStatus.codeSent;
  bool get isError => status == PhoneAuthStatus.error;

  PhoneAuthState copyWith({
    PhoneAuthStatus? status,
    String? phoneNumber,
    String? verificationId,
    String? errorMessage,
  }) =>
      PhoneAuthState(
        status: status ?? this.status,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        verificationId: verificationId ?? this.verificationId,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}

class PhoneAuthNotifier extends StateNotifier<PhoneAuthState> {
  PhoneAuthNotifier(this._repo) : super(const PhoneAuthState());

  final AuthRepository _repo;

  Future<void> sendOtp(String phoneNumber) async {
    state = PhoneAuthState(
      status: PhoneAuthStatus.loading,
      phoneNumber: phoneNumber,
    );

    await _repo.sendPhoneOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (id) {
        state = state.copyWith(
          status: PhoneAuthStatus.codeSent,
          verificationId: id,
        );
      },
      onError: (msg) {
        state = state.copyWith(
          status: PhoneAuthStatus.error,
          errorMessage: msg,
        );
      },
    );
  }

  Future<void> verifyOtp(String smsCode) async {
    if (state.verificationId == null) return;
    state = state.copyWith(status: PhoneAuthStatus.verifying, errorMessage: null);
    try {
      await _repo.verifyOtp(
        verificationId: state.verificationId!,
        smsCode: smsCode,
      );
      // Success: Firebase auth state changes → router redirect handles navigation
    } catch (e) {
      state = state.copyWith(
        status: PhoneAuthStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void reset() => state = const PhoneAuthState();
}

final phoneAuthProvider =
    StateNotifierProvider.autoDispose<PhoneAuthNotifier, PhoneAuthState>(
  (ref) => PhoneAuthNotifier(ref.watch(authRepositoryProvider)),
);
