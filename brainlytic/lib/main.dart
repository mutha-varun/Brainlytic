import 'package:brainlytic/core/theme/theme.dart';
import 'package:brainlytic/features/onboarding/pages/initial_screen.dart';
import 'package:brainlytic/features/onboarding/pages/onboarding.dart';
import 'package:brainlytic/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  
  runApp(
    ProviderScope(
      child: const Brainlytic()
    )
  );
  
}

class Brainlytic extends StatelessWidget {
  const Brainlytic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Brainlytic",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      // home: StreamBuilder(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
          
      //     if(snapshot.data != null){
      //       return HomeScreen();
      //     }
      //     return Onboarding();
      //   },
      // )
      home: const Onboarding(),
    );
  }
}