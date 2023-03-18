import 'dart:ui';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:highlight/languages/dart.dart';
CodeController getCodeController(String script) {
  return CodeController(
    text: script,
    language: dart,
    patternMap: {
      r'"(?:[^"\\]|\\.)*"': const TextStyle(color: Colors.deepPurple),
      r'\w+\s*\([^)]*\)': const TextStyle(color: Colors.green),
      r'\b(?:void|char|int|float|double|if|else|while|for|do|switch|case|break|continue|return)\b':
      const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    },
    stringMap: {
      "printf":
      const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      "scanf":
      const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      "main":
      const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
    },
  );
}
