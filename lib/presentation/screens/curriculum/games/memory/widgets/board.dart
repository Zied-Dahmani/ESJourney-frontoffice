import 'package:flutter/material.dart';
import 'package:esjourney/presentation/screens/curriculum/games/memory/utils/utils.dart' as utils;

Widget board(String title, String info) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          color: utils.whiteColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(info,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
        ],
      ),
    ),
  );
}
