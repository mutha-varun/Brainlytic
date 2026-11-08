import 'package:flutter/material.dart';

class AnswerTile extends StatelessWidget {
  final String content;
  final Color color;
  const AnswerTile({
    required this.color,
    required this.content,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 30, left: 8, right: 8),
      width: double.infinity, 
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text(content,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}