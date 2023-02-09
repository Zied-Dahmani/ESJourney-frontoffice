import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFFEB4A5A),
        onPrimary: Colors.white,
        secondary: Color(0xFF3C3C3E),
        onSecondary: Colors.white,
        tertiary: Color(0xFFA8A9A9),
        background: Color(0xFFF8F8F8),
        onBackground: Colors.black,
        error: Color(0xFFEB4A5A),
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, color: Color(0xFF3C3C3E)),
      headlineMedium: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Color(0xFF3C3C3E)),
      bodyLarge: TextStyle(fontSize: 18.0, color: Color(0xFFEFEFEF)),
      bodyMedium: TextStyle(fontSize: 16.0, color: Color(0xFF3C3C3E)),
      bodySmall: TextStyle(fontSize: 14.0, color: Color(0xFFEFEFEF)),
    ),
    scaffoldBackgroundColor: const Color(0xFFF8F8F8
),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF8F8F8
),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(
          color: Color(0xFFEB4A5A), fontSize: 14.0, fontWeight: FontWeight.normal),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
        borderSide: const BorderSide(color: Color(0xFFEB4A5A), width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
        borderSide: const BorderSide(color: Colors.black, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          borderSide: const BorderSide(color: Colors.black, width: 2.0)),
      labelStyle: const TextStyle(fontSize: 16.0, color: Color(0xFF3C3C3E)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
      ),
    )),
    iconTheme:
        const IconThemeData(color: Colors.black, size: AppSizes.kiconSize),
    dividerTheme: const DividerThemeData(color: Color(0xFFEFEFEF)),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(fontSize: 16.0, color: Color(0x00f8f8f8)),
    ));

class AppSizes {
  static const khugeSpace = 28.0;
  static const kbigSpace = 20.0;
  static const ksmallSpace = 10.0;

  static const kdividerHeight = 2.0;

  static const kradius = 20.0;
  static const kiconSize = 24.0;
  static const kiconBackgroundSize = 60.0;
  static const kiconBackgroundRadius = 99.0;
}
