import 'package:esjourney/presentation/screens/curriculum/games/hangman/utils/consts.dart';
import 'package:flutter/material.dart';

Widget hiddenLetter(String char, bool visible) {
  return FittedBox(
    child: Container(
      padding: const EdgeInsets.all(18.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Visibility(
        visible: !visible,
        child: Text(
          char,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: AppColors.bgColor,
          ),
        ),
      ),
    ),
  );
}
