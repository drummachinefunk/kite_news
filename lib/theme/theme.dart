import 'package:flutter/material.dart';

class KagiTheme {
  static ThemeData createLightTheme() => _createTheme(
    brightness: Brightness.light,
    primary: const Color.fromARGB(255, 234, 119, 12),
    secondary: const Color.fromARGB(255, 214, 162, 7),
    surface: Colors.white,
    onSurface: Colors.black,
    error: Colors.red,
  );

  static ThemeData createDarkTheme() => _createTheme(
    brightness: Brightness.dark,
    primary: Colors.amber,
    secondary: Colors.amber,
    surface: const Color(0xFF151515),
    onSurface: Colors.white,
    error: Colors.red,
  );

  static ThemeData _createTheme({
    required Brightness brightness,
    required Color primary,
    required Color secondary,
    required Color surface,
    required Color onSurface,
    required Color error,
  }) {
    final data = ThemeData(
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primary,
        primary: primary,
        secondary: secondary,
        surface: surface,
        onSurface: onSurface,
        error: error,
      ),
      textTheme: TextTheme(
        displaySmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ), // from 36
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onSurface.withAlpha(150),
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
        labelSmall: TextStyle(
          fontSize: 12,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w500,
          color: onSurface,
        ),
      ),
    );

    return data;
  }
}
