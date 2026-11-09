import 'package:brainlytic/core/theme/pallete.dart';
import 'package:brainlytic/features/auth/pages/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sign-out",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium
      ),
      content: Text("You want to sign-out?",
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("No",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Pallete.indigo700Color
            )
          )
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<AuthBloc>().add(SignoutEvent());
          },
          child: Text("Yes",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Pallete.redColor
            )
          )
        )

      ],
    );
  }
}