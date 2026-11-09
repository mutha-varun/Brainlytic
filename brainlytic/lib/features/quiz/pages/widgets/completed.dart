import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Completed extends StatelessWidget {
  final int score;
  final int length;

  const Completed({
    required this.score,
    required this.length,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Quiz Completed",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium
      ),
      content: Text("Your score is $score out of $length",
        softWrap: true,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleSmall
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.pop();
          },
          child: Text("OK",
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Pallete.indigo700Color
            )
          )
        )
      ],
    );
  }
}
