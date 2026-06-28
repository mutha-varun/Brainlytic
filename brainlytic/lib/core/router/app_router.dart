import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/onboarding/router/onboarding_routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteConstants.initialScreen,
  routes: [
    ...OnboardingRoutes.route,
  ]
);