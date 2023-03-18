import 'package:esjourney/presentation/screens/curriculum/games/worldy/constants/answer_stages.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/data/keys_map.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/model/tile_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Controller extends ChangeNotifier {
  bool checkLine = false,
      backOrEnterTapped = false,
      gameWon = false,
      gameCompleted = false,
      notEnoughLetters = false;
  String correctWord = "";
  int currentTile = 0, currentRow = 0;
  List<TileModel> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value}) {
    if (value == 'ENTER') {
      backOrEnterTapped = true;
      if (currentTile == correctWord.length * (currentRow + 1)) {
        checkWord();
      } else {
        notEnoughLetters = true;
      }
    } else if (value == 'BACK') {
      backOrEnterTapped = true;
      notEnoughLetters = false;
      if (currentTile > correctWord.length * (currentRow + 1) - correctWord.length) {
        currentTile--;
        tilesEntered.removeLast();
      }
    } else {
      backOrEnterTapped = false;
      notEnoughLetters = false;
      if (currentTile < correctWord.length * (currentRow + 1)) {
        tilesEntered.add(
            TileModel(letter: value, answerStage: AnswerStage.notAnswered));
        currentTile++;
      }
    }
    notifyListeners();
  }

  checkWord() {
    List<String> guessed = [], remainingCorrect = [];
    String guessedWord = "";

    for (int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
      guessed.add(tilesEntered[i].letter);
    }

    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      for (int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
        gameWon = true;
        gameCompleted = true;
      }
    } else {
      for (int i = 0; i < correctWord.length; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * correctWord.length)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }

      for (int i = 0; i < remainingCorrect.length; i++) {
        for (int j = 0; j < correctWord.length; j++) {
          if (remainingCorrect[i] ==
              tilesEntered[j + (currentRow * correctWord.length)].letter) {
            if (tilesEntered[j + (currentRow * correctWord.length)].answerStage !=
                AnswerStage.correct) {
              tilesEntered[j + (currentRow * correctWord.length)].answerStage =
                  AnswerStage.contains;
            }

            final resultKey = keysMap.entries.where((element) =>
            element.key == tilesEntered[j + (currentRow * correctWord.length)].letter);

            if (resultKey.single.value != AnswerStage.correct) {
              keysMap.update(
                  resultKey.single.key, (value) => AnswerStage.contains);
            }
          }
        }
      }
      for (int i = currentRow * correctWord.length; i < (currentRow * correctWord.length) + correctWord.length; i++) {
        if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
          tilesEntered[i].answerStage = AnswerStage.incorrect;

          final results = keysMap.entries
              .where((element) => element.key == tilesEntered[i].letter);
          if (results.single.value == AnswerStage.notAnswered) {
            keysMap.update(
                tilesEntered[i].letter, (value) => AnswerStage.incorrect);
          }
        }
      }
    }
    checkLine = true;
    currentRow++;

    if (currentRow == correctWord.length) {
      gameCompleted = true;
    }

    //TODO: display word + definition
    /*if (gameCompleted) {
      calculateStats(gameWon: gameWon);
      if (gameWon) {
        setChartStats(currentRow: currentRow);
      }
    }*/

    notifyListeners();
  }

  clearTiles() {
    tilesEntered.clear();
    currentTile = 0;
    currentRow = 0;
    checkLine = false;
    gameWon = false;
    gameCompleted = false;
    notEnoughLetters = false;
    backOrEnterTapped = false;
    //clear keyboard key colors
    keysMap.forEach((key, value) {
      keysMap.update(key, (value) => AnswerStage.notAnswered);
    });
    notifyListeners();
  }
}
