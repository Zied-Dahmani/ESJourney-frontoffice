import 'package:flutter/material.dart';

class TranslateAnimation extends StatelessWidget {
  final Widget child;

  const TranslateAnimation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        tween: Tween(begin: 1.0, end: 0.0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutBack,
        builder: (context, value, _child) {
          return Transform.translate(
            offset: Offset(0.0, 100.0 * value),
            child: child,
          );
        },
        child: child);
  }
}
