import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleState = ref.watch(googleSignInProvider);

    // Show error snackbar on Google sign-in failure
    ref.listen(googleSignInProvider, (_, next) {
      final msg = next.error;
      if (msg != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(msg),
            backgroundColor: OjasColors.error,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: OjasColors.deepPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: OjasDimensions.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.self_improvement,
                size: 80,
                color: OjasColors.saffron,
              ),
              const SizedBox(height: OjasDimensions.lg),
              const Text(
                'Ojas Healing',
                style: OjasTextStyles.displayLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: OjasDimensions.sm),
              const Text(
                'Your spiritual wellness companion',
                style: OjasTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: OjasDimensions.xxl),

              // Google Sign-In
              PrimaryButton(
                label: 'Continue with Google',
                isLoading: googleState.isLoading,
                onPressed: () =>
                    ref.read(googleSignInProvider.notifier).signIn(),
                icon: const Icon(
                  Icons.g_mobiledata,
                  color: OjasColors.cream,
                  size: 22,
                ),
              ),

              const SizedBox(height: OjasDimensions.md),

              // Phone OTP
              OutlinedButton.icon(
                onPressed: () => context.push(Routes.phoneOtp),
                icon: const Icon(Icons.phone),
                label: const Text('Continue with Phone'),
                style: OutlinedButton.styleFrom(
                  minimumSize:
                      const Size.fromHeight(OjasDimensions.buttonHeight),
                ),
              ),

              const SizedBox(height: OjasDimensions.xl),
              Text(
                'By continuing you agree to our Terms of Service\nand Privacy Policy',
                style: OjasTextStyles.bodySmall.copyWith(
                  color: OjasColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
