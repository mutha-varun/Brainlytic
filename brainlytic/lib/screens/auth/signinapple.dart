import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class SigninApple extends StatefulWidget {
  const SigninApple({super.key});

  @override
  State<SigninApple> createState() => _SigninAppleState();
}

class _SigninAppleState extends State<SigninApple> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top:10,bottom: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.apple,
        onPressed: (){

        },
        width: MediaQuery.of(context).size.width,
        btnText: "Continue with Apple",
        buttonSize: ButtonSize.large,
        btnColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 3,
      ),
    );
  }
}