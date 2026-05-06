import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/ojas_app_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_dimensions.dart';

class ServicesScreen extends ConsumerWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const OjasAppBar(title: 'Healing Services'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(OjasDimensions.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.healing_outlined, size: 64, color: OjasColors.saffron),
              const SizedBox(height: OjasDimensions.md),
              const Text('Healing Services', style: OjasTextStyles.headlineLarge),
              const SizedBox(height: OjasDimensions.sm),
              Text(
                'Steps 23–26 — Booking feature coming soon',
                style: OjasTextStyles.bodyMedium.copyWith(color: OjasColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
