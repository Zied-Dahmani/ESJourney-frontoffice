import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.red,
        onPrimary: Colors.white,
        secondary: Colors.black,
        onSecondary: Colors.white,
        tertiary: Colors.grey,
        background: Colors.white,
        onBackground: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black),
      headlineMedium: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.grey),
      bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black),
      bodySmall: TextStyle(fontSize: 14.0, color: Colors.grey),
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(
          color: Colors.red, fontSize: 14.0, fontWeight: FontWeight.normal),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
        borderSide: const BorderSide(color: Colors.black, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          borderSide: const BorderSide(color: Colors.black, width: 2.0)),
      labelStyle: const TextStyle(fontSize: 16.0, color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
      ),
    )),
    iconTheme:
        const IconThemeData(color: Colors.black, size: AppSizes.kiconSize),
    dividerTheme: const DividerThemeData(color: Colors.grey),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Colors.black,
      contentTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
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
