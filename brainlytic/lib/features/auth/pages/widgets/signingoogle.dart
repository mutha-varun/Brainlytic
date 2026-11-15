import 'package:brainlytic/core/router/route_constants.dart';
import 'package:brainlytic/core/utility/utils.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SigninGoogle extends StatefulWidget {
  const SigninGoogle({super.key});

  @override
  State<SigninGoogle> createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {

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
          onPressed: state is AuthLoading?null : 
            (){
              context.read<AuthBloc>().add(GoogleSigninEvent());
            },
          icon: Image.asset("assets/google.png", width: 30),
          iconAlignment: IconAlignment.start,
          label: state is AuthLoading? 
            const Circularindicator() : const Text("Continue with Google"),
        );
      },
    );
  }
}
