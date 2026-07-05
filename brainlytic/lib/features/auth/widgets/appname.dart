import 'package:flutter/material.dart';

class Appname extends StatelessWidget {

  final String displayText;
  const Appname({required this.displayText ,super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25,),
        Text("Brainlytic",
          style: Theme.of(context).textTheme.titleLarge
        ),
        const SizedBox(height: 30,),
        Text(displayText,
          style: Theme.of(context).textTheme.headlineLarge
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}