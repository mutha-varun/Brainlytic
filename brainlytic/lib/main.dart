import 'package:brainlytic/firebase_options.dart';
import 'package:brainlytic/screens/auth/onboarding.dart';
import 'package:brainlytic/screens/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  
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