import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class QuestionTile extends StatelessWidget {

  final String question;
  const QuestionTile({
    required this.question,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 9, right: 9),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Pallete.snackBarColor,
        border: BoxBorder.all(
          color: Pallete.focusedBorderColor
        ),
      ),
      alignment: Alignment.center,
      child: Text(question,
        textAlign: TextAlign.center,
        softWrap: true,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}