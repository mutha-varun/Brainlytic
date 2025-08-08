import 'dart:async';
// ignore: unused_import
import 'dart:io';
import 'package:brainlytic/screens/home/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';

const List<String> scopes = <String>[
  'https://www.googleapis.com/auth/contacts.readonly',
];

String? clientId;
String? serverClientId;

class SigninGoogle extends StatefulWidget {
  const SigninGoogle({super.key});

  @override
  State<SigninGoogle> createState() => _SigninGoogleState();
}

class _SigninGoogleState extends State<SigninGoogle> {

  
 
  String _errorMessage = '';

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


  Future<UserCredential> signInWithGoogle() async{
    try{
      final googleProvider = GoogleAuthProvider();

      googleProvider.addScope('email');
      googleProvider.addScope('profile');

      googleProvider.setCustomParameters({
        'prompt': 'select_account'
      });

      if(defaultTargetPlatform == TargetPlatform.android){
        return await FirebaseAuth.instance.signInWithProvider(googleProvider);
      }
      else{
        await FirebaseAuth.instance.signOut();
        try{
          return await FirebaseAuth.instance.signInWithPopup(googleProvider);
        }catch(e){
          if(e is FirebaseAuthException && e.code == 'popup-closed-by-user'){
            throw Exception('Sign-in cancelled by user');
          }

          throw Exception('Failed to sign in with Google');
        }
      
      }
    }catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
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
            try{
              final userCredential = await signInWithGoogle();

              await createUserData(userCredential);
              
              if(context.mounted){
                Navigator.pushReplacement(context, 
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(
                      name: userCredential.user?.displayName ?? "User"
                    )
                  )
                );
              }
            }catch (e){
              if(context.mounted){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(_errorMessage),
                    backgroundColor: Colors.red,
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