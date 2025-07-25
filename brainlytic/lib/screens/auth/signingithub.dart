import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';


class SigninGitHub extends StatefulWidget {
  const SigninGitHub({super.key});

  @override
  State<SigninGitHub> createState() => _SigninGitHubState();
}

class _SigninGitHubState extends State<SigninGitHub> {

  Future<UserCredential> signinGitHub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20,right: 20, top:10,bottom: 10),
      height: 60,
      child: SignInButton(
        buttonType: ButtonType.github,
        onPressed: (){

        },
        width: MediaQuery.of(context).size.width,
        btnText: "Continue with GitHub",
        buttonSize: ButtonSize.large,
        btnColor: Color.fromRGBO(250, 250, 250, 1),
        elevation: 3,
      ),
    );
  }
}