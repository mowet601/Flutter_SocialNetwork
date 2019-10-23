import 'package:flutter/material.dart';

enum ThemeKeys { White, Black }

class Themes {
  static final ThemeData whitetheme = ThemeData(
      fontFamily: 'Didact',
      backgroundColor: Colors.white,
      brightness: Brightness.light,
      buttonColor: Colors.orange,
      textTheme: TextTheme(
        headline: TextStyle(
          color: Colors.black,
        ),
        subhead: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(0, 0, 0, 0.8),
        ),
        subtitle: TextStyle(
          color: Colors.black26,
        ),
        overline: TextStyle(
          color: Colors.black54,
          fontSize: 16,
          letterSpacing: 0,
        ),
        display1: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.red,
          letterSpacing: 0.2,
          height: 1.1,
          fontSize: 20,
        ),
        caption: TextStyle(
          color: Colors.white,
          letterSpacing: 0.2,
          height: 1.1,
          fontSize: 16,
        ),
      ),
      accentColor: Colors.black87,
      iconTheme: IconThemeData(
        color: Colors.black,
        size: 20,
      ));

  static final ThemeData blacktheme = ThemeData(
    accentColor: Colors.white70,
    fontFamily: 'Didact',
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    buttonColor: Colors.purple,
    textTheme: TextTheme(
      headline: TextStyle(
        color: Colors.white,
      ),
      subhead: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
      subtitle: TextStyle(
        color: Colors.white24,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 20,
    ),
  );

  static ThemeData getThemeFromKey(ThemeKeys themeKey) {
    switch (themeKey) {
      case ThemeKeys.White:
        return whitetheme;
      case ThemeKeys.Black:
        return blacktheme;
      default:
        return whitetheme;
    }
  }
}
