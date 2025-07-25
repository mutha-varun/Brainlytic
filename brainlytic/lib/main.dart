// ignore_for_file: unused_import

import 'package:brainlytic/firebase_options.dart';
import 'package:brainlytic/screens/auth/register.dart';
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
      home: Register()
    );
  }
}