import 'dart:async';

import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/data/datasources/firebase_auth_datasources.dart';
import 'package:brainlytic/features/auth/router/auth_routes.dart';
import 'package:brainlytic/features/home/router/home_routes.dart';
import 'package:brainlytic/features/onboarding/router/onboarding_routes.dart';
import 'package:brainlytic/features/quiz/router/quiz_routes.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';


final routeObserver = RouteObserver<PageRoute>();

late final GoRouter appRouter = _createAppRouter();

GoRouter _createAppRouter() {
  final authDataSource = FirebaseAuthDatasources();
  final authRefresh = _GoRouterRefreshStream(authDataSource.authStateChanges);

  return GoRouter(
    initialLocation: RouteConstants.initialScreenPath,
    refreshListenable: authRefresh,
    redirect: (context, state) {
      if (authDataSource.currentUser != null &&
          state.matchedLocation == RouteConstants.initialScreenPath) {
        return '/home';
      }
      return null;
    },
    observers: [routeObserver],
    routes: [
      ...OnboardingRoutes.route,
      ...AuthRoutes.route,
      ...HomeRoutes.route,
      ...QuizRoutes.route,
    ],
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<Object?> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<Object?> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}