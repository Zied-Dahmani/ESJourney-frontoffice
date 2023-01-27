import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xff170B3B),
        onPrimary: Colors.white,
        secondary: Color(0xffB19FF9),
        onSecondary: Colors.white,
        tertiary: Colors.grey,
        background: Color(0xff170B3B),
        onBackground: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        surface: Color(0xff170B3B),
        onSurface: Colors.white),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 18.0, color: Colors.grey),
      bodyMedium: TextStyle(fontSize: 16.0, color: Colors.grey),
      bodySmall: TextStyle(fontSize: 14.0, color: Colors.grey),
    ),
    scaffoldBackgroundColor: const Color(0xff170B3B),
    appBarTheme: const AppBarTheme(
      color: Color(0xff170B3B),
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
        borderSide: const BorderSide(color: Colors.grey, width: 2.0),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          borderSide: const BorderSide(color: Color(0xffB19FF9), width: 2.0)),
      labelStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.kradius),
      ),
    )),
    iconTheme:
        const IconThemeData(color: Colors.white, size: AppSizes.kiconSize),
    dividerTheme: const DividerThemeData(color: Colors.grey),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Color(0xffB19FF9)),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xffB19FF9),
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
