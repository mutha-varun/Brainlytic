import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:brainlytic/features/common/widgets/circularindicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class SigninGitHub extends StatefulWidget {
  final AuthState? state;
  const SigninGitHub({this.state, super.key});

  @override
  State<SigninGitHub> createState() => _SigninGitHubState();
}

class _SigninGitHubState extends State<SigninGitHub> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: widget.state is AuthLoading
          ? null
          : () => context.read<AuthBloc>().add(GithubSigninEvent()),
      icon: Image.asset("assets/github.png", width: 30),
      iconAlignment: IconAlignment.start,
      label: widget.state is GithubSigninLoading
          ? const Circularindicator()
          : const Text("Continue with Github"),
    );
  }
}
