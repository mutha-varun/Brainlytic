import 'dart:async';
import 'package:brainlytic/screens/home/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/sign_button.dart';

class SigninGoogle extends StatefulWidget {
  const SigninGoogle({super.key});

  @override
  State<SigninGoogle> createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {
 
  Future<UserCredential?> singinWithGoogle() async{
    try{
     
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization =
      await authorizationClient.authorizationForScopes([
        'email',
        'profile',
      ]);
      authorization ??= await authorizationClient.authorizeScopes(['email', 'profile']);

      final accessToken = authorization.accessToken;
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> createUserData(UserCredential userCredential) async {
    try {
      final user = userCredential.user;
      if (user != null) {
        // Create user document with initial data
        await FirebaseFirestore.instance
        .collection('userData')
        .doc(user.uid)
        .set({
          "uid": user.uid,
        });
        // Create initial quiz data
        for (int i = 1; i <= 8; i++) {
          await FirebaseFirestore.instance
          .collection('userData')
          .doc(user.uid)
          .collection('quizData')
          .doc('quiz$i')
          .set({
            'stars': 0,
            'id': i,
          });
        }
      }
    } catch (e) {
      print('Error creating user data: $e');
      rethrow;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 60,
        child: SignInButton(
          buttonType: ButtonType.google, 
          onPressed: () async {
          final user = await singinWithGoogle();
          if(user != null){
            if(user.additionalUserInfo?.isNewUser ?? false){
              await createUserData(user);
            }
            if(context.mounted){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(name: "",)
                )
              );
            }
          }
          },
          btnText: "Continue with Google",
          width: MediaQuery.of(context).size.width,
          buttonSize: ButtonSize.large,
        ),
    );
  }
}