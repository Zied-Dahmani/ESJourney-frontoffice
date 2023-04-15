import 'package:flutter/material.dart';

class GameLogic {
  final String hiddenCard = 'assets/images/curriculum/games/memory/images/box.png';
  List<String>? cardsImg;
  String level = '';

  late List<String> cardList = [];

  var axiCount = 0;
  var cardCount = 0;
  List<Map<int, String>> matchCheck = [];

  void initGame(BuildContext context) {

      cardCount = 30;
      axiCount = 6;
      cardList = [
        'assets/images/curriculum/games/memory/images/angry-birds.png',
        'assets/images/curriculum/games/memory/images/bomberman.png',
        'assets/images/curriculum/games/memory/images/angry-birds.png',
        'assets/images/curriculum/games/memory/images/carnivorous-plant.png',
        'assets/images/curriculum/games/memory/images/game-console.png',
        'assets/images/curriculum/games/memory/images/gamepad.png',
        'assets/images/curriculum/games/memory/images/carnivorous-plant.png',
        'assets/images/curriculum/games/memory/images/game-console.png',
        'assets/images/curriculum/games/memory/images/angry-birds.png',
        'assets/images/curriculum/games/memory/images/angry-birds.png',
        'assets/images/curriculum/games/memory/images/game-pad.png',
        'assets/images/curriculum/games/memory/images/game-pad.png',
        'assets/images/curriculum/games/memory/images/carnivorous-plant.png',
        'assets/images/curriculum/games/memory/images/carnivorous-plant.png',
        'assets/images/curriculum/games/memory/images/gamepad.png',
        'assets/images/curriculum/games/memory/images/minecraft.png',
        'assets/images/curriculum/games/memory/images/minecraft.png',
        'assets/images/curriculum/games/memory/images/pick.png',
        'assets/images/curriculum/games/memory/images/pick.png',
        'assets/images/curriculum/games/memory/images/bomberman.png',
        'assets/images/curriculum/games/memory/images/pick.png',
        'assets/images/curriculum/games/memory/images/pick.png',
        'assets/images/curriculum/games/memory/images/game-console.png',
        'assets/images/curriculum/games/memory/images/game-console.png',
        'assets/images/curriculum/games/memory/images/game-console.png',
        'assets/images/curriculum/games/memory/images/game-console.png',
        'assets/images/curriculum/games/memory/images/bomberman.png',
        'assets/images/curriculum/games/memory/images/bomberman.png',
        'assets/images/curriculum/games/memory/images/minecraft.png',
        'assets/images/curriculum/games/memory/images/minecraft.png',
      ];

    cardList.shuffle();
    cardsImg = List<String>.generate(cardCount, (index) {
      return hiddenCard;
    });
  }
}
