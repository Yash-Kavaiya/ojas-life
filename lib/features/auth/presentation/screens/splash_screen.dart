import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/route_constants.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _rotationCtrl;
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;
  bool _minDelayPassed = false;

  @override
  void initState() {
    super.initState();

    _rotationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _scaleAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOutBack),
    );
    _fadeCtrl.forward();

    Future.delayed(const Duration(milliseconds: 2600), () {
      if (mounted) setState(() => _minDelayPassed = true);
    });
  }

  @override
  void dispose() {
    _rotationCtrl.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateChangesProvider);

    // Once min delay + auth state are both ready, hand off to router
    if (_minDelayPassed && !authState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        context.go(
          authState.valueOrNull != null ? Routes.home : Routes.login,
        );
      });
    }

    return Scaffold(
      backgroundColor: OjasColors.deepPurple,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Rotating mandala / lotus icon
                RotationTransition(
                  turns: _rotationCtrl,
                  child: Container(
                    width: 128,
                    height: 128,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const SweepGradient(
                        colors: [
                          OjasColors.saffron,
                          OjasColors.gold,
                          OjasColors.lotus,
                          OjasColors.saffron,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: OjasColors.saffron.withValues(alpha: 0.45),
                          blurRadius: 32,
                          spreadRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.self_improvement,
                      size: 64,
                      color: OjasColors.cream,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Hindi primary title
                const Text('ओजस', style: OjasTextStyles.displayLarge),

                const SizedBox(height: 4),

                // English branding
                Text(
                  'OJAS  HEALING',
                  style: OjasTextStyles.labelLarge.copyWith(
                    letterSpacing: 6,
                    color: OjasColors.saffron,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Meditation  •  Healing  •  Transformation',
                  style: OjasTextStyles.bodySmall,
                ),

                const SizedBox(height: 40),

                // Loading dots
                _PulsingDots(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Three pulsing dots — visual loading indicator on the splash.
class _PulsingDots extends StatefulWidget {
  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) {
            final delay = i * 0.2;
            final raw = (_ctrl.value - delay).clamp(0.0, 1.0);
            final opacity = Curves.easeInOut.transform(raw);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Opacity(
                opacity: 0.3 + opacity * 0.7,
                child: const CircleAvatar(
                  radius: 4,
                  backgroundColor: OjasColors.saffron,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
