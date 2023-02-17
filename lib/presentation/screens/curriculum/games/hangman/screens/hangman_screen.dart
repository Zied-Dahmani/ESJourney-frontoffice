import 'package:esjourney/presentation/screens/curriculum/games/hangman/utils/consts.dart';
import 'package:esjourney/presentation/screens/curriculum/games/hangman/widgets/figure_widget.dart';
import 'package:esjourney/presentation/screens/curriculum/games/hangman/widgets/hidden_letter.dart';
import 'package:flutter/material.dart';

class HangmanScreen extends StatefulWidget {
  const HangmanScreen({Key? key}) : super(key: key);

  @override
  State<HangmanScreen> createState() => HangmanScreenState();
}

class HangmanScreenState extends State<HangmanScreen> {
  var characters = "abcdefghijklmnopqrstuvwxyz".toUpperCase();
  var word = "flutter".toUpperCase();
  List<String> selectedChar = [];
  var tries = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Hangman'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      figure(GameUI.hang, tries >= 0),
                      figure(GameUI.head, tries >= 1),
                      figure(GameUI.body, tries >= 2),
                      figure(GameUI.leftArm, tries >= 3),
                      figure(GameUI.rightArm, tries >= 4),
                      figure(GameUI.leftLeg, tries >= 5),
                      figure(GameUI.rightLeg, tries >= 6),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 4.0,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: word
                        .split("")
                        .map(
                          (e) => hiddenLetter(
                              e, !selectedChar.contains(e.toUpperCase())),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 6,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                children: characters.split("").map(
                  (e) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.bgColor,
                      ),
                      onPressed: selectedChar.contains(e.toUpperCase())
                          ? null
                          : () {
                              setState(() {
                                selectedChar.add(e.toUpperCase());
                                if (!word.split("").contains(e.toUpperCase())) {
                                  tries++;
                                }
                              });
                            },
                      child: Text(
                        e,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
