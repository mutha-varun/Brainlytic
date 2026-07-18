import 'package:brainlytic/core/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme{

  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      style: BorderStyle.solid,
      width: 1.5
    ),
    borderRadius: BorderRadius.circular(50)
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.scaffoldColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Pallete.seedColor,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: _border(Pallete.enabledBorderColor),
      focusedBorder: _border(Pallete.focusedBorderColor),
      errorBorder: _border(Pallete.redColor),
      focusedErrorBorder: _border(Pallete.redColor),
      errorStyle: TextStyle(
        fontSize: 13,
        color: Pallete.redColor
      ),
      labelStyle: TextStyle(
        fontSize: 19,
        color: Pallete.enabledBorderColor
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 19,
        color: Pallete.indigo700Color
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(360, 55),
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
        shape: StadiumBorder(),
        alignment: Alignment.center
      )
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(360, 55),
        textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
          height: 1.5,
        ),
        shape: StadiumBorder(),
        alignment: Alignment.center
      )
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.25,
        height: 1.12,
      ),

      //no refactoring
      displayMedium: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.bold,
        height: 1.16,
      ),

      displaySmall: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        height: 1.22,
      ),

      //no refactoring
      headlineLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),

      //no refactoring
      headlineMedium: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        height: 1.29,
      ),

      //no refactoring
      headlineSmall: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        height: 1.33,
      ),

      //no refactoring
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        height: 1.27,
      ),

      //no refactoring
      titleMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.5,
      ),

      // no refactoring
      titleSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      

      //no refactoring
      bodyLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      labelLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    )
  );
}