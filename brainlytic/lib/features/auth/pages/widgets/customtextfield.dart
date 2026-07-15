import 'package:flutter/material.dart';

class Customtextfield extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool autofocus;
  const Customtextfield({
    required this.controller,
    required this.text,
    this.autofocus = false,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16, top: 15, bottom: 16),
      width: 360,
      height: 60,
      child: TextFormField(
        controller: controller,
        autofocus: autofocus,
        validator: (value) {
          if(value!.isEmpty){
            return "$text cannot be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: text,
        ),
        style: Theme.of(context).textTheme.bodyLarge
      ),
    ); 
  }
}