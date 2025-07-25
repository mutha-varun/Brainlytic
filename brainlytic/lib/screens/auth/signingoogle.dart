import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';

class SigninGoogle extends StatefulWidget {
  const SigninGoogle({super.key});

  @override
  State<SigninGoogle> createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {

  final GoogleSignIn signIn = GoogleSignIn.instance;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20,top:20,bottom: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.google,
        onPressed: () async{

        },
        width: MediaQuery.of(context).size.width,
        btnText: "Continue with Google",
        buttonSize: ButtonSize.large,
        btnColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 3,
      ),
    );
  }
}