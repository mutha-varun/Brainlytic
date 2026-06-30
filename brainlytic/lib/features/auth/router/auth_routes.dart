import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/login_password.dart';
import 'package:brainlytic/features/auth/login_username.dart';
import 'package:brainlytic/features/auth/register.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {

  static final route = [
    GoRoute(
      name: RouteConstants.loginUsername,
      path: '/loginUsername',
      builder: (context, state)=> LoginUsername()
    ),
    GoRoute(
      name: RouteConstants.loginPassword,
      path: '/loginPassword',
      builder: (context, state)=> LoginPassword()
    ),
    GoRoute(
      name: RouteConstants.register,
      path: '/register',
      builder: (context, state)=> const Register()
    )
  ];
}