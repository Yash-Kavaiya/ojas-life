import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/ojas_app_bar.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_provider.dart';

class PhoneOtpScreen extends ConsumerStatefulWidget {
  const PhoneOtpScreen({super.key});

  @override
  ConsumerState<PhoneOtpScreen> createState() => _PhoneOtpScreenState();
}

class _PhoneOtpScreenState extends ConsumerState<PhoneOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneCtrl = TextEditingController();
  String _countryCode = '+91';

  static const _countryCodes = ['+91', '+1', '+44', '+971', '+65', '+61'];

  @override
  void dispose() {
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phoneAuthProvider);

    // Navigate to OTP verify when code is sent
    ref.listen<PhoneAuthState>(phoneAuthProvider, (previous, next) {
      if (next.isCodeSent && !(previous?.isCodeSent ?? false)) {
        context.push(Routes.otpVerify);
      }
      if (next.isError && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: OjasColors.error,
          ),
        );
      }
    });

    return Scaffold(
      appBar: const OjasAppBar(title: 'Enter Phone Number'),
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
                  'Your phone number',
                  style: OjasTextStyles.headlineMedium,
                ),
                const SizedBox(height: OjasDimensions.sm),
                const Text(
                  'We\'ll send a one-time code to verify your number.',
                  style: OjasTextStyles.bodyMedium,
                ),

                const SizedBox(height: OjasDimensions.xl),

                // Country code + phone field
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country code picker
                    Container(
                      height: OjasDimensions.inputHeight,
                      padding: const EdgeInsets.symmetric(
                        horizontal: OjasDimensions.sm,
                      ),
                      decoration: BoxDecoration(
                        color: OjasColors.surfacePurple,
                        borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _countryCode,
                          dropdownColor: OjasColors.surfacePurple,
                          style: OjasTextStyles.bodyMedium,
                          items: _countryCodes
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c),
                                ),
                              )
                              .toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _countryCode = val);
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: OjasDimensions.sm),

                    // Phone number input
                    Expanded(
                      child: TextFormField(
                        controller: _phoneCtrl,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(12),
                        ],
                        style: OjasTextStyles.bodyLarge,
                        decoration: const InputDecoration(
                          hintText: '98765 43210',
                        ),
                        validator: (v) {
                          if (v == null || v.length < 7) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                PrimaryButton(
                  label: 'Send OTP',
                  isLoading: state.isLoading,
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;
                    final fullNumber = '$_countryCode${_phoneCtrl.text.trim()}';
                    ref.read(phoneAuthProvider.notifier).sendOtp(fullNumber);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
