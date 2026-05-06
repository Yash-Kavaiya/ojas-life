import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class OjasLoadingIndicator extends StatelessWidget {
  const OjasLoadingIndicator({super.key, this.size = 40.0});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          strokeWidth: 2.5,
          color: OjasColors.saffron,
          backgroundColor: OjasColors.cardPurple,
        ),
      ),
    );
  }
}

/// Full-screen loading overlay
class OjasLoadingScreen extends StatelessWidget {
  const OjasLoadingScreen({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OjasColors.deepPurple,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const OjasLoadingIndicator(size: 48),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: const TextStyle(color: OjasColors.textSecondary, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
