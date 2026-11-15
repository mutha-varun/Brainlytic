import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/utility/utils.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninGitHub extends StatefulWidget {
  const SigninGitHub({super.key});

  @override
  State<SigninGitHub> createState() => _SigninGitHubState();
}

class _SigninGitHubState extends State<SigninGitHub> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state is AuthFailure){
          showSnackBar(context, state.message);
        }

        if(state is AuthSuccess){
          context.goNamed(RouteConstants.home);
        }
      },
      builder: (context, state) {
        return ElevatedButton.icon(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () async {},
          icon: Image.asset("assets/github.png", width: 30),
          iconAlignment: IconAlignment.start,
          label: state is AuthLoading? 
            const Circularindicator() : const Text("Continue with Github"),
        );
      },
    );
  }
}
