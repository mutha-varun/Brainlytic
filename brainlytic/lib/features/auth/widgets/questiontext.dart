import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class Questiontext extends StatelessWidget {
  final String text;

  final String buttonText;
  final VoidCallback onTap;
  const Questiontext({
    required this.text,
    required this.buttonText,
    required this.onTap,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            letterSpacing: -0.2
          )
        ),
        TextButton(
          onPressed: onTap, 
          child: Text("Sign up",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              letterSpacing: -0.2,
              color: Pallete.indigo700Color,
              decoration: TextDecoration.underline
            )
          )
        )
      ],
    );
  }
}