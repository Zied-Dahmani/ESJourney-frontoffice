import 'dart:async';

import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/curriculum/games/memory/logic/game_logic.dart';
import 'package:esjourney/presentation/screens/curriculum/games/memory/utils/utils.dart'
    as utils;
import 'package:esjourney/presentation/screens/curriculum/games/memory/widgets/board.dart';
import 'package:flutter/material.dart';

class MemoryScreen extends StatefulWidget {
  const MemoryScreen({Key? key}) : super(key: key);

  @override
  State<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends State<MemoryScreen> {
  final GameLogic _game = GameLogic();

  var levelForCardCount = 0;
  var tries = 0;
  var score = 0;
  var axisNumber = 4;
  late Timer timer;
  int startTime = 200;
  String level = '';
  var complete = 0;

  void startTimer(BuildContext context) {
    if (startTime == 0) {}
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSecond,
      (timer) {
        if (startTime == 0) {
          timer.cancel();
          _showDialog(context, 'Game Over', 'Your score: $score');
        } else {
          setState(
            () {
              startTime--;
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _game.initGame(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        timer.cancel();
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Confirm dialog'),
            actions: <Widget>[
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: utils.redColor),
                onPressed: () {
                  willLeave = true;
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  startTimer(context);
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: utils.blueColor),
                ),
              ),
            ],
          ),
        );
        return willLeave;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: utils.redColor,
          leading: IconButton(
            onPressed: () {
              timer.cancel();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Memory',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.restorablePushReplacementNamed(
                    context, AppRoutes.memoryGame);
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: utils.redColor,
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                board('Time', '$startTime'),
                board('Score', '$score'),
                board('Moves', '$tries')
              ],
            ),
            SizedBox(
              height: screenWidth,
              width: screenWidth,
              child: GridView.builder(
                itemCount: _game.cardsImg!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _game.axiCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          tries++;

                          _game.cardsImg![index] = _game.cardList[index];

                          _game.matchCheck.add({index: _game.cardList[index]});

                          if (_game.matchCheck.length == 2) {
                            if (_game.matchCheck[0].values.first ==
                                _game.matchCheck[1].values.first) {
                              score += 100;
                              complete += 1;

                              _game.matchCheck.clear();
                              if (complete * 2 == _game.cardCount) {
                                _showDialog(context, 'Congratulations',
                                    'Your score: $score');
                                timer.cancel();
                              }
                            } else {
                              Future.delayed(
                                const Duration(milliseconds: 500),
                                () {
                                  setState(
                                    () {
                                      _game.cardsImg![_game.matchCheck[0].keys
                                          .first] = _game.hiddenCard;
                                      _game.cardsImg![_game.matchCheck[1].keys
                                          .first] = _game.hiddenCard;

                                      _game.matchCheck.clear();
                                    },
                                  );
                                },
                              );
                            }
                          }
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: utils.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(_game.cardsImg![index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String title, String info) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(info),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.restorablePushReplacementNamed(
                    context, AppRoutes.memoryGame);
              },
            )
          ],
        );
      },
    );
  }
}
