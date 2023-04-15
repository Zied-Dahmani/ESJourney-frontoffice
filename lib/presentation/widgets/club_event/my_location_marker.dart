import 'dart:ui';
import 'package:flutter/material.dart';

class MyLocationMarker extends AnimatedWidget {
  const MyLocationMarker({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(.5, 1.0, value)!;
    return Stack(
      children: [
        Center(
          child: Container(
            height: 50 * newValue,
            width: 50 * newValue,
            decoration: BoxDecoration(
                color: theme.colorScheme.outline.withOpacity(.5),
                shape: BoxShape.circle),
          ),
        ),
        Center(
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: theme.colorScheme.outline, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
