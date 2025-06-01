import 'package:flutter/material.dart';

class KagiTheme {
  static ThemeData createLightTheme() => _createTheme(
    brightness: Brightness.light,
    primary: Colors.deepPurple,
    secondary: Colors.amber,
    surface: Colors.white,
    error: Colors.red,
  );

  static ThemeData createDarkTheme() => _createTheme(
    brightness: Brightness.dark,
    primary: Colors.deepPurple,
    secondary: Colors.amber,
    surface: Colors.black,
    error: Colors.red,
  );

  static ThemeData _createTheme({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color surface,
    required Color error,
  }) {
    return ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
        error: error,
      ),
    );
  }
}
