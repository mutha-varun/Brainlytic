import 'package:flutter/material.dart';

class Passwordtextfield extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isObscured;
  final bool autoFocus;
  
  const Passwordtextfield({
    required this.controller,
    required this.onTap,
    required this.isObscured,
    this.autoFocus = false,
    super.key
  });

  @override
  State<Passwordtextfield> createState() => _PasswordtextfieldState();
}

class _PasswordtextfieldState extends State<Passwordtextfield> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 15,
      ),
      width: 360,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isObscured,
        autofocus: widget.autoFocus,
        validator: (value) {
          if (value!.isEmpty) {
            return "Password cannot be empty";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: IconButton(
            onPressed: widget.onTap,
            icon: Icon(
              widget.isObscured
                  ? Icons.visibility
                  : Icons.visibility_off,
              size: 30,
            ),
          ),
        ),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}