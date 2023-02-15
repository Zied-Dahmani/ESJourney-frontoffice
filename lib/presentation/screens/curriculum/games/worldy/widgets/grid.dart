import 'package:esjourney/presentation/screens/curriculum/games/worldy/animations/bounce.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/animations/dance.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/provider/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tile.dart';

class Grid extends StatefulWidget {
   const Grid({
    Key? key, required this.word,
  }) : super(key: key);

  final String? word;

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String correctWord = widget.word!;
    print("correct: "+correctWord);
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(36, 20, 36, 20),
        itemCount: (correctWord.length) * 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          crossAxisCount: correctWord.length,
        ),
        itemBuilder: (context, index) {
          return Consumer<Controller>(
            builder: (_, notifier, __) {
              bool animate = false;
              bool animateDance = false;
              int danceDelay = 1600;
              if (index == (notifier.currentTile - 1) &&
                  !notifier.backOrEnterTapped) {
                animate = true;
              }
              if (notifier.gameWon) {
                for (int i = notifier.tilesEntered.length - correctWord.length;
                    i < notifier.tilesEntered.length;
                    i++) {
                  if (index == i) {
                    animateDance = true;
                    danceDelay += 150 * (i - ((notifier.currentRow - 1) * correctWord.length));
                  }
                }
              }
              return Dance(
                delay: danceDelay,
                animate: animateDance,
                child: Bounce(
                    animate: animate,
                    child: Tile(
                      index: index,
                    )),
              );
            },
          );
        });
  }
}
