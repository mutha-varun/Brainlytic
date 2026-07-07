import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Questiontext extends StatefulWidget {
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
  State<Questiontext> createState() => _QuestiontextState();
}

class _QuestiontextState extends State<Questiontext> {

  late final TapGestureRecognizer _gestureRecognizer;
  @override
  void initState() {
    super.initState();
    _gestureRecognizer = TapGestureRecognizer()..onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "${widget.text} ",
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(
            text: widget.buttonText,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              letterSpacing: -0.2,
              color: Pallete.indigo700Color,
              decoration: TextDecoration.underline
            ),
            recognizer: _gestureRecognizer
          )
        ]
      )
    );
  }
}