import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.scaffoldColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFFF9100),
      brightness: Brightness.dark,
    ),
    
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 37,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
      titleLarge: TextStyle(
       fontWeight: FontWeight.bold,
        fontSize: 22
      ),
    )
  );
}