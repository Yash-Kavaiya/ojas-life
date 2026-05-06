import 'package:go_router/go_router.dart';
import '../constants/route_constants.dart';
import '../../shared/widgets/ojas_shell.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/content/presentation/screens/video_library_screen.dart';
import '../../features/live_sessions/presentation/screens/live_sessions_screen.dart';
import '../../features/booking/presentation/screens/services_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/phone_otp_screen.dart';
import '../../features/auth/presentation/screens/otp_verify_screen.dart';

List<RouteBase> get appRoutes => [
      // Splash — always accessible, handles its own auth-driven navigation
      GoRoute(
        path: Routes.splash,
        builder: (_, __) => const SplashScreen(),
      ),

      // Auth flow routes (outside shell — no bottom nav)
      GoRoute(
        path: Routes.login,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: Routes.phoneOtp,
        builder: (_, __) => const PhoneOtpScreen(),
      ),
      GoRoute(
        path: Routes.otpVerify,
        builder: (_, __) => const OtpVerifyScreen(),
      ),

      // Shell — bottom navigation with 5 persistent branches
      StatefulShellRoute.indexedStack(
        builder: (_, __, shell) => OjasShell(shell: shell),
        branches: [
          // Branch 0 — Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.home,
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),

          // Branch 1 — Learn (video library + courses)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.learn,
                builder: (_, __) => const VideoLibraryScreen(),
              ),
            ],
          ),

          // Branch 2 — Live sessions
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.live,
                builder: (_, __) => const LiveSessionsScreen(),
              ),
            ],
          ),

          // Branch 3 — Heal (booking)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.heal,
                builder: (_, __) => const ServicesScreen(),
              ),
            ],
          ),

          // Branch 4 — Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profile,
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ];
