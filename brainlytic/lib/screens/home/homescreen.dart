import 'package:brainlytic/screens/home/quiz_topics_templates.dart';
import 'package:flutter/material.dart';


class Homescreen extends StatelessWidget {
  final String name;
  const Homescreen({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hey!$name"),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index){
          return QuizTopicsTemplates(color: Colors.red);
        },
      )
    );
  }
}