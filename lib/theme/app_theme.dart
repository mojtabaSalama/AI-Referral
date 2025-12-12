import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF2BEE79);
  static const Color backgroundLight = Color(0xFFF6F8F7);
  static const Color backgroundDark = Color(0xFF102217);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF193324);
  static const Color inputBorderDark = Color(0xFF326747);
  static const Color textSecondaryDark = Color(0xFF92C9A8);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: primary.withOpacity(0.8),
        surface: surfaceLight,
        background: backgroundLight,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundLight.withOpacity(0.9),
        titleTextStyle: TextStyle(
          fontFamily: 'SplineSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontFamily: 'SplineSans', fontWeight: FontWeight.bold, color: Colors.black87),
        bodyLarge: TextStyle(fontFamily: 'SplineSans', color: Colors.black87),
        bodyMedium: TextStyle(fontFamily: 'SplineSans', color: Colors.black54),
        labelSmall: TextStyle(fontFamily: 'SplineSans', color: Colors.grey.shade600),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: backgroundDark,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: primary.withOpacity(0.8),
        surface: surfaceDark,
        background: backgroundDark,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundDark.withOpacity(0.9),
        titleTextStyle: TextStyle(
          fontFamily: 'SplineSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: inputBorderDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: inputBorderDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(fontFamily: 'SplineSans', fontWeight: FontWeight.bold, color: Colors.white),
        bodyLarge: TextStyle(fontFamily: 'SplineSans', color: Colors.white),
        bodyMedium: TextStyle(fontFamily: 'SplineSans', color: textSecondaryDark),
        labelSmall: TextStyle(fontFamily: 'SplineSans', color: textSecondaryDark),
      ),
    );
  }
}