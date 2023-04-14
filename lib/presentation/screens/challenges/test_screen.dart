import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Widget platformButton({
  required String label,
  required VoidCallback onPressed,
}) {
  return Platform.isIOS
      ? CupertinoButton(
    onPressed: onPressed,
    child: Text(label),
  )
      : ElevatedButton(
    onPressed: onPressed,
    child: Text(label),
  );
}
