import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/route_constants.dart';
import '../providers/firebase_providers.dart';
import 'app_routes.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: appRoutes,
    debugLogDiagnostics: false,
  );
});

/// Listens to auth state changes and notifies GoRouter to re-evaluate redirects.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(authStateChangesProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    // Splash handles its own navigation; never intercept it
    if (state.matchedLocation == Routes.splash) return null;

    final authState = _ref.read(authStateChangesProvider);

    // Don't redirect while auth state is still loading
    if (authState.isLoading) return null;

    final isLoggedIn = authState.valueOrNull != null;
    const authRoutes = {Routes.login, Routes.phoneOtp, Routes.otpVerify};
    final isOnAuthRoute = authRoutes.contains(state.matchedLocation);

    if (!isLoggedIn && !isOnAuthRoute) return Routes.login;
    if (isLoggedIn && isOnAuthRoute) return Routes.home;

    return null;
  }
}
