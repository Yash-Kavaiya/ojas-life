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
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();

  String _countryCode = '+91';
  String _gender = '';

  static const _countryCodes = ['+91', '+1', '+44', '+971', '+65', '+61'];
  static const _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(phoneAuthProvider);

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
      appBar: const OjasAppBar(title: 'Create Account'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(OjasDimensions.xl),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: OjasDimensions.sm),

                // Header
                const Text(
                  'Tell us about yourself',
                  style: OjasTextStyles.headlineLarge,
                ),
                const SizedBox(height: OjasDimensions.xs),
                const Text(
                  'We\'ll personalise your healing journey.',
                  style: OjasTextStyles.bodyMedium,
                ),

                const SizedBox(height: OjasDimensions.xl),

                // Full Name
                _FieldLabel(label: 'Full Name'),
                const SizedBox(height: OjasDimensions.xs),
                TextFormField(
                  controller: _nameCtrl,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  style: OjasTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    hintText: 'Arjun Sharma',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().length < 2) {
                      return 'Enter your full name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: OjasDimensions.lg),

                // Gender
                _FieldLabel(label: 'Gender'),
                const SizedBox(height: OjasDimensions.sm),
                Row(
                  children: _genders.map((g) {
                    final selected = _gender == g;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: g != _genders.last ? OjasDimensions.sm : 0,
                        ),
                        child: _GenderChip(
                          label: g,
                          selected: selected,
                          onTap: () => setState(() => _gender = g),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (_gender.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: OjasDimensions.xs, left: OjasDimensions.xs),
                    child: Text(
                      'Please select a gender',
                      style: OjasTextStyles.bodySmall.copyWith(
                        color: OjasColors.error,
                      ),
                    ),
                  ),

                const SizedBox(height: OjasDimensions.lg),

                // Phone Number
                _FieldLabel(label: 'Phone Number'),
                const SizedBox(height: OjasDimensions.xs),
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
                        borderRadius:
                            BorderRadius.circular(OjasDimensions.radiusMd),
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
                            if (val != null) {
                              setState(() => _countryCode = val);
                            }
                          },
                        ),
                      ),
                    ),

                    const SizedBox(width: OjasDimensions.sm),

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
                          prefixIcon: Icon(Icons.phone_outlined),
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

                const SizedBox(height: OjasDimensions.lg),

                // City
                _FieldLabel(label: 'City'),
                const SizedBox(height: OjasDimensions.xs),
                TextFormField(
                  controller: _cityCtrl,
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  style: OjasTextStyles.bodyLarge,
                  decoration: const InputDecoration(
                    hintText: 'Mumbai',
                    prefixIcon: Icon(Icons.location_city_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Enter your city';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: OjasDimensions.xxl),

                PrimaryButton(
                  label: 'Send OTP',
                  isLoading: authState.isLoading,
                  onPressed: _submit,
                ),

                const SizedBox(height: OjasDimensions.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    // Validate gender separately since it's not a TextFormField
    final genderMissing = _gender.isEmpty;
    final formValid = _formKey.currentState!.validate();

    if (!formValid || genderMissing) return;

    // Persist registration data for use after OTP verification
    ref.read(registrationDataProvider.notifier).state = RegistrationData(
      name: _nameCtrl.text.trim(),
      gender: _gender,
      city: _cityCtrl.text.trim(),
    );

    final fullNumber = '$_countryCode${_phoneCtrl.text.trim()}';
    ref.read(phoneAuthProvider.notifier).sendOtp(fullNumber);
  }
}

// ---------------------------------------------------------------------------
// Local widgets
// ---------------------------------------------------------------------------

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: OjasTextStyles.labelLarge.copyWith(color: OjasColors.textSecondary),
    );
  }
}

class _GenderChip extends StatelessWidget {
  const _GenderChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: OjasDimensions.inputHeight,
        decoration: BoxDecoration(
          color: selected ? OjasColors.saffron : OjasColors.surfacePurple,
          borderRadius: BorderRadius.circular(OjasDimensions.radiusMd),
          border: Border.all(
            color: selected ? OjasColors.saffron : OjasColors.cardPurple,
            width: 1.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: OjasTextStyles.labelLarge.copyWith(
            color: selected ? OjasColors.cream : OjasColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
