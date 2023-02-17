import 'package:flutter/material.dart';

Widget figure(String path, bool visible) {
  return SizedBox(
    child: Visibility(
      visible: visible,
      child: Image.asset(path),
    ),
  );
}