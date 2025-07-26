import 'package:flutter/material.dart';

class QuizTopicsTemplates extends StatelessWidget {
  final Color color;

  const QuizTopicsTemplates(
    {
      super.key,
      required this.color,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      //padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color,
      ),
      child: Column(
        
      ),
    );
  }
}