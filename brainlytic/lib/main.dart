// ignore_for_file: unused_import

import 'package:brainlytic/firebase_options.dart';
import 'package:brainlytic/screens/auth/login_username.dart';
import 'package:brainlytic/screens/auth/onboarding.dart';
import 'package:brainlytic/screens/auth/register.dart';
import 'package:brainlytic/screens/home/homescreen.dart';
import 'package:brainlytic/screens/quiz/quizpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Brainlytic());
}

class Brainlytic extends StatelessWidget {
  const Brainlytic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Brainlytic",

      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: LinearProgressIndicator(
                
              )
            );
          }
          if(snapshot.data != null){
            return HomeScreen(
              name: FirebaseAuth.instance.currentUser!.displayName!
            );
          }
          
          return Onboarding();
        },
        
      )
      //home: Onboarding()
    );
  }
}