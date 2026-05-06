import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/ojas_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_provider.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpCtrl = TextEditingController();
  bool _canResend = false;
  int _resendCountdown = 60;
  late final _resendTimer = _startResendTimer();

  @override
  void dispose() {
    _otpCtrl.dispose();
    _resendTimer.cancel();
    super.dispose();
  }

  // Simple countdown so user doesn't spam OTP requests
  dynamic _startResendTimer() {
    return Stream.periodic(const Duration(seconds: 1), (i) => i)
        .take(60)
        .listen((i) {
      if (!mounted) return;
      setState(() {
        _resendCountdown = 59 - i;
        if (_resendCountdown <= 0) _canResend = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneAuthProvider);

    // Show error snackbar on failed verification
    ref.listen<PhoneAuthState>(phoneAuthProvider, (_, next) {
      if (next.isError && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: OjasColors.error,
          ),
        );
      }
    });

    final phone = state.phoneNumber ?? '';

    return Scaffold(
      appBar: const OjasAppBar(title: 'Verify OTP'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(OjasDimensions.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: OjasDimensions.lg),

                const Text(
                  'Enter verification code',
                  style: OjasTextStyles.headlineMedium,
                ),
                const SizedBox(height: OjasDimensions.sm),

                RichText(
                  text: TextSpan(
                    style: OjasTextStyles.bodyMedium,
                    children: [
                      const TextSpan(text: 'We sent a 6-digit code to '),
                      TextSpan(
                        text: phone,
                        style: OjasTextStyles.bodyMedium.copyWith(
                          color: OjasColors.saffron,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: OjasDimensions.xxl),

                // OTP input — large spaced digits
                TextFormField(
                  controller: _otpCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: OjasColors.cream,
                    letterSpacing: 16,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: '------',
                    hintStyle: TextStyle(
                      fontSize: 32,
                      letterSpacing: 16,
                      color: OjasColors.textMuted,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: OjasDimensions.lg,
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.length != 6) {
                      return 'Enter the 6-digit code';
                    }
                    return null;
                  },
                  onChanged: (v) {
                    if (v.length == 6) {
                      // Auto-submit when all digits entered
                      _submit();
                    }
                  },
                ),

                const SizedBox(height: OjasDimensions.xl),

                // Resend OTP
                Center(
                  child: _canResend
                      ? TextButton(
                          onPressed: () {
                            _otpCtrl.clear();
                            ref.read(phoneAuthProvider.notifier).sendOtp(phone);
                            setState(() {
                              _canResend = false;
                              _resendCountdown = 60;
                              _startResendTimer();
                            });
                          },
                          child: const Text('Resend OTP'),
                        )
                      : Text(
                          'Resend in ${_resendCountdown}s',
                          style: OjasTextStyles.bodySmall,
                        ),
                ),

                const Spacer(),

                PrimaryButton(
                  label: 'Verify',
                  isLoading: state.isLoading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref.read(phoneAuthProvider.notifier).verifyOtp(_otpCtrl.text.trim());
  }
}
