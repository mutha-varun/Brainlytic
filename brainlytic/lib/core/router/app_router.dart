import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/router/auth_routes.dart';
import 'package:brainlytic/features/home/router/home_routes.dart';
import 'package:brainlytic/features/onboarding/router/onboarding_routes.dart';
import 'package:brainlytic/features/quiz/router/quiz_routes.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteConstants.initialScreen,
  routes: [
    ...OnboardingRoutes.route,
    ...AuthRoutes.route,
    ...HomeRoutes.route,
    ...QuizRoutes.route
  ]
);