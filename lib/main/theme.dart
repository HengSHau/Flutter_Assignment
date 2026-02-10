import 'package:flutter/material.dart';

class Themes{
  static ThemeData lightTheme(){
    return ThemeData.light(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 255, 255, 255),
          onPrimary: Color.fromARGB(255, 0, 0, 0), 
          secondary: Color.fromARGB(255, 100, 160, 240), 
          onSecondary: Color.fromARGB(255, 255, 255, 255),
          surface: Color.fromARGB(255, 0, 0, 0)
      )
    );
  } 

  static ThemeData darkTheme(){
    return ThemeData.dark(
      useMaterial3: true,
    ).copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 20, 20, 20),
          onPrimary: Color.fromARGB(255,255,255,255),
          secondary: Color.fromARGB(255, 129, 104, 196),
          onSecondary: Color.fromARGB(255,255,255,255),
          surface: Color.fromARGB(255,255,255,255)
      )
    );
  }

}