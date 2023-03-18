import 'package:flutter/material.dart';

void showInfoSnackBar(
  BuildContext context,
  String text, {
  Color? backroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      backgroundColor: backroundColor ?? Colors.black.withOpacity(0.8),
      content: Text(text),
    ),
  );
}
