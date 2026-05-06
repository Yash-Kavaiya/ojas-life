import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/ojas_app_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const OjasAppBar(title: 'Profile'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(OjasDimensions.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.person_outline, size: 64, color: OjasColors.saffron),
              const SizedBox(height: OjasDimensions.md),
              const Text('Profile', style: OjasTextStyles.headlineLarge),
              const SizedBox(height: OjasDimensions.sm),
              Text(
                'Step 32 — Profile feature coming soon',
                style: OjasTextStyles.bodyMedium.copyWith(color: OjasColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
