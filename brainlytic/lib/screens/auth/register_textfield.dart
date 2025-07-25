import 'package:flutter/material.dart';

class RegisterTextfield extends StatefulWidget {
  final TextEditingController? controller;
  final String text;
  const RegisterTextfield(
    {
      super.key,
      this.controller,
      required this.text
    });

  @override
  State<RegisterTextfield> createState() => _RegisterTextfieldState();
}

class _RegisterTextfieldState extends State<RegisterTextfield> {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,right: 16, top: 5, bottom: 16),
      width: 400,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          label: Text(widget.text),
          labelStyle: TextStyle(
            fontSize: 19,
            color: Colors.grey.shade600
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 19,
            color: Colors.indigoAccent.shade400
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              style: BorderStyle.solid,
              width: 1.5
            ),
            borderRadius: BorderRadius.circular(50)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              color: Colors.indigoAccent.shade400,
              width: 1.5
            )
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto
        ),
      ),
    );
  }
}