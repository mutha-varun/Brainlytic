import 'package:brainlytic/firebase_options.dart';
import 'package:brainlytic/features/auth/data/datasources/firebase_auth_datasources.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_ui/material_ui.dart';



final initProvider = FutureProvider<void>((ref) async {

  final minSplashDuration =
    Future<void>.delayed(const Duration(seconds: 3));

  try{
    Future<void> step(String name, Future<void> Function() fn) async {
      debugPrint('init: $name start');
      await fn().timeout(const Duration(seconds: 10));
      debugPrint('init: $name done');
    }

    await step('firebase', () async {
      await step('dotenv', () => dotenv.load(fileName: '.env'));
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    });
    await FirebaseAuthDatasources().authStateChanges.first;
    
    await step('google', () => GoogleSignIn.instance.initialize());
  }finally{
    await minSplashDuration;
  }
  
});