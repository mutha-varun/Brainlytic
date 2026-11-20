import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninGoogle extends StatefulWidget {
  final AuthState? state;
  const SigninGoogle({this.state , super.key});

  @override
  State<SigninGoogle> createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {

  @override
  Widget build(BuildContext context) {
        return ElevatedButton.icon(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: widget.state is GoogleSignInLoading? null : 
            (){
              context.read<AuthBloc>().add(GoogleSigninEvent());
            },
          icon: Image.asset("assets/google.png", width: 30),
          iconAlignment: IconAlignment.start,
          label: widget.state is GoogleSignInLoading? 
            const Circularindicator() : const Text("Continue with Google"),
        );
  }
}
