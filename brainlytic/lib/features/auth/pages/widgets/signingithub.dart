import 'package:brainlytic/core/router/route_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class SigninGitHub extends StatefulWidget {
  const SigninGitHub({super.key});

  @override
  State<SigninGitHub> createState() => _SigninGitHubState();
}

class _SigninGitHubState extends State<SigninGitHub>{

  Future<UserCredential?> signinGitHub() async {
    try{
      GithubAuthProvider githubAuthProvider = GithubAuthProvider();

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);

      
      return userCredential;
    }catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> createUserData(UserCredential credential) async{
    try{
      final user = credential.user;

      if(user!=null){
        await FirebaseFirestore.instance.
        collection("userData").doc(user.uid).set(
          {
            "uid":user.uid
          }
        );

        for(int i =1; i<=8;i++){
          await FirebaseFirestore.instance.
          collection("userData").doc(user.uid).
          collection("quizData").doc('quiz$i').set(
            {
              "stars":0,
              "id":i
            }
          );
        }
      }
    }catch (e){
      print("Error creating user data");
      rethrow;
    }
  }
  @override
  Widget build(BuildContext context){
    return ElevatedButton.icon(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: () async {
        final user = await signinGitHub();
          if(user != null){
            if(user.additionalUserInfo?.isNewUser ?? false){
              await createUserData(user);
            }
            if(context.mounted){
              context.goNamed(RouteConstants.home);
            }
          }
      },
      icon: Image.asset(
        "assets/github.png",
        width: 30,
      ),
      iconAlignment: IconAlignment.start,
      label: const Text("Continue with Github"),
    );
  }
}