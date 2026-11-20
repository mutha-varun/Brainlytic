import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/onboarding/pages/initial_screen.dart';
import 'package:brainlytic/features/onboarding/pages/onboarding.dart';
import 'package:brainlytic/features/onboarding/pages/splash_screen.dart';
import 'package:go_router/go_router.dart';

class OnboardingRoutes {

  static final route = [
    GoRoute(
      name: RouteConstants.splash,
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: RouteConstants.initialScreen,
      path: '/initialScreen',
      builder: (context, state) => const InitialScreen(),
    ),
    GoRoute(
      name: RouteConstants.onboarding,
      path: '/onboarding',
      builder: (context, state) => const Onboarding(),
    )
  ];
}