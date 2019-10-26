import 'package:flutter/material.dart';

enum ThemeKeys { White, Black }

class Themes {
  static final ThemeData whitetheme = ThemeData(
      fontFamily: 'Didact',
      backgroundColor: Colors.white,
      cardColor: Color.fromRGBO(0, 0, 0, 0.05),
      brightness: Brightness.light,
      buttonColor: Colors.black,
      textTheme: TextTheme(
        headline: TextStyle(
          color: Colors.black,
        ),
        title: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(0, 0, 0, 0.8),
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
        // Writeups
        display1: TextStyle(
          color: Colors.black,
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

  /// Dark theme for the app
  /// Includes text theme, icon theme and app theme
  static final ThemeData blacktheme = ThemeData(
    accentColor: Colors.white70,
    fontFamily: 'Didact',
    backgroundColor: Colors.black,
    cardColor: Color.fromRGBO(255, 255, 255, 0.05),
    brightness: Brightness.dark,
    buttonColor: Colors.white,
    textTheme: TextTheme(
      headline: TextStyle(
        color: Colors.white,
      ),
      // Title on app bar
      title: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      subhead: TextStyle(
        fontSize: 18,
        color: Colors.white,
      ),
      // Writeups
      display1: TextStyle(
        color: Colors.white,
        letterSpacing: 0.2,
        height: 1.1,
        fontSize: 20,
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
