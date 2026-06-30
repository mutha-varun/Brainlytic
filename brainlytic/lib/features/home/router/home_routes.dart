import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/home/homescreen.dart';
import 'package:go_router/go_router.dart';

class HomeRoutes {
  static final route = [
    GoRoute(
      name: RouteConstants.home,
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    )
  ];
}