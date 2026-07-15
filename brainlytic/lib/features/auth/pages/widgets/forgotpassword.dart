import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onTap;
  const ForgotPassword({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 12, bottom: 6),
      child: TextButton(
        onPressed: onTap, 
        child: Text("Forgot Password?",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Pallete.indigo700Color
          )
        )
      ),
    );
  }
}