import 'dart:math';

import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/provider/controller.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/utils/quick_box.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/widgets/grid.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/widgets/keyboard_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/words.dart';

class WordlyPage extends StatefulWidget {
  const WordlyPage({Key? key}) : super(key: key);

  @override
  State<WordlyPage> createState() => WordlyPageState();
}

class WordlyPageState extends State<WordlyPage> {
  late String _word;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    _word = words[r];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: _word);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordle'),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Provider.of<Controller>(context,
                listen: false).clearTiles();
            Navigator.pop(context);
          },
        ),
        actions: [
          Consumer<Controller>(
            builder: (_, notifier, __) {
              if (notifier.notEnoughLetters) {
                runQuickBox(context: context, message: 'Not Enough Letters');
              }
              if (notifier.gameCompleted) {
                if (notifier.gameWon) {
                  if (notifier.currentRow == 5) {
                    runQuickBox(context: context, message: 'Phew!');
                  } else {
                    runQuickBox(context: context, message: 'Splendid!');
                  }
                } else {
                  runQuickBox(context: context, message: notifier.correctWord);
                }
                Future.delayed(
                  const Duration(milliseconds: 4000),
                  () {
                    if (mounted) {
                      print("first");
                      //TODO: check what to do here
                      /*showDialog(context: context, builder: (_) => const StatsBox());*/
                    }
                  },
                );
              }
              return const SizedBox();
            },
          ),
          IconButton(
            onPressed: () {
              Provider.of<Controller>(context, listen: false).clearTiles();
              Navigator.restorablePushReplacementNamed(context, AppRoutes.wordlyGame);
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(
            height: 1,
            thickness: 2,
          ),
          Expanded(
            flex: 7,
            child: Grid(
              word: _word,
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children:const  [
                KeyboardRow(
                  min: 1,
                  max: 10,
                ),
                KeyboardRow(
                  min: 11,
                  max: 19,
                ),
                KeyboardRow(
                  min: 20,
                  max: 29,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
