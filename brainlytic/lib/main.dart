import 'package:brainlytic/firebase_options.dart';
import 'package:brainlytic/screens/auth/onboarding.dart';
import 'package:brainlytic/screens/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const Brainlytic());
  
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
          
          if(snapshot.data != null){
            return HomeScreen(
              name: FirebaseAuth.instance.currentUser!.displayName!
            );
          }
          return Onboarding();
        },
      )
    );
  }
}