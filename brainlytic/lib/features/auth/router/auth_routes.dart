import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/features/auth/pages/login_password.dart';
import 'package:brainlytic/features/auth/pages/login_username.dart';
import 'package:brainlytic/features/auth/pages/register.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {

  static final route = [
    GoRoute(
      name: RouteConstants.loginUsername,
      path: '/loginUsername',
      builder: (context, state){ 
        String? email = state.uri.queryParameters['text'];
        return LoginUsername(email: email,);
      }
    ),
    GoRoute(
      name: RouteConstants.loginPassword,
      path: '/loginPassword',
      builder: (context, state){ 
        String email = state.uri.queryParameters['email']!;
        return LoginPassword(email: email);
      }
    ),
    GoRoute(
      name: RouteConstants.register,
      path: '/register',
      builder: (context, state)=> const Register()
    )
  ];
}