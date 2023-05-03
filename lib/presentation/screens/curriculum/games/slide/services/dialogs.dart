import 'dart:async';

import 'package:esjourney/presentation/screens/curriculum/games/slide/consts/Textstyles/text_styles.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/models/score.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/tools/board_controller.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/widgets/output/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class PuzzleDialog {

  void gameRest({required BuildContext context, required Function() confirm}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
                opacity: a1.value,
                child: ResetGameDialog(
                  action: confirm,
                )),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }

  void gameEnded({required BuildContext context, required Score score}) {
    var prov = Provider.of<BoardController>(context, listen: false);

    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: ChangeNotifierProvider<BoardController>.value(
                value: prov,
                builder: (context, child) {
                  return GameEndedDialog(score: score);
                },
              ),
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {
          return const SizedBox();
        });
  }
}

class GameEndedDialog extends StatefulWidget {
  final Score score;

  const GameEndedDialog({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  State<GameEndedDialog> createState() => _GameEndedDialogState();
}

class _GameEndedDialogState extends State<GameEndedDialog> {
  late int minutes, seconds;

  @override
  void initState() {
    super.initState();
    minutes = widget.score.time.inMinutes % 60;
    seconds = widget.score.time.inSeconds % 60;
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      large: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    'Congratulations!!',
                    style: SlideTextStyle.instructions
                        .copyWith(color: Colors.black, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "puzzle solved in ",
                          style: SlideTextStyle.heading16.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16),
                          children: [
                            if (minutes > 0)
                              TextSpan(
                                  text: "$minutes min",
                                  style: SlideTextStyle.heading18.copyWith(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 18)),
                            TextSpan(
                              text: ",",
                              style: SlideTextStyle.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: "$seconds sec",
                                style: SlideTextStyle.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " by moving ",
                              style: SlideTextStyle.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: widget.score.moves.toString(),
                                style: SlideTextStyle.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " tiles, score is:\n",
                              style: SlideTextStyle.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                          ])),
                  Text(
                    widget.score.points.toString(),
                    style: SlideTextStyle.instructions
                        .copyWith(color: Colors.black, fontSize: 32),
                  ),
                  Text(
                    "points",
                    style: SlideTextStyle.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SDashtar()
            ],
          ),
        ),
      ),
      medium: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Text(
                    'Congratulations!!',
                    style: SlideTextStyle.instructions
                        .copyWith(color: Colors.black, fontSize: 28),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                          text: "puzzle solved in ",
                          style: SlideTextStyle.heading16.copyWith(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 16),
                          children: [
                            if (minutes > 0)
                              TextSpan(
                                  text: "$minutes min",
                                  style: SlideTextStyle.heading18.copyWith(
                                      color: Colors.black.withOpacity(0.9),
                                      fontSize: 18)),
                            TextSpan(
                              text: ",",
                              style: SlideTextStyle.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: "$seconds sec",
                                style: SlideTextStyle.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " by moving ",
                              style: SlideTextStyle.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                            TextSpan(
                                text: widget.score.moves.toString(),
                                style: SlideTextStyle.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                            TextSpan(
                              text: " tiles, score is:\n",
                              style: SlideTextStyle.heading16.copyWith(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 16),
                            ),
                          ])),
                  Text(
                    widget.score.points.toString(),
                    style: SlideTextStyle.instructions
                        .copyWith(color: Colors.black, fontSize: 32),
                  ),
                  Text(
                    "points",
                    style: SlideTextStyle.heading16.copyWith(
                        color: Colors.black.withOpacity(0.5), fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const SDashtar()
            ],
          ),
        ),
      ),
      small: AlertDialog(
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(16.0)),
        content: Stack(
          alignment: Alignment.topCenter,
          children: [
            const SDashtar(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  'Congratulations!!',
                  style: SlideTextStyle.instructions
                      .copyWith(color: Colors.black, fontSize: 28),
                ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                        text: "puzzle solved in ",
                        style: SlideTextStyle.heading16.copyWith(
                            color: Colors.black.withOpacity(0.5), fontSize: 16),
                        children: [
                          if (minutes > 0)
                            TextSpan(
                                text: "$minutes min",
                                style: SlideTextStyle.heading18.copyWith(
                                    color: Colors.black.withOpacity(0.9),
                                    fontSize: 18)),
                          TextSpan(
                            text: ",",
                            style: SlideTextStyle.heading16.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: "$seconds sec",
                              style: SlideTextStyle.heading18.copyWith(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 18)),
                          TextSpan(
                            text: " by moving ",
                            style: SlideTextStyle.heading16.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16),
                          ),
                          TextSpan(
                              text: widget.score.moves.toString(),
                              style: SlideTextStyle.heading18.copyWith(
                                  color: Colors.black.withOpacity(0.9),
                                  fontSize: 18)),
                          TextSpan(
                            text: " tiles, score is:\n",
                            style: SlideTextStyle.heading16.copyWith(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 16),
                          ),
                        ])),
                Text(
                  widget.score.points.toString(),
                  style: SlideTextStyle.instructions
                      .copyWith(color: Colors.black, fontSize: 32),
                ),
                Text(
                  "points",
                  style: SlideTextStyle.heading16.copyWith(
                      color: Colors.black.withOpacity(0.5), fontSize: 16),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResetGameDialog extends StatefulWidget {
  Function() action;

  ResetGameDialog({
    Key? key,
    required this.action,
  }) : super(key: key);

  @override
  State<ResetGameDialog> createState() => _ResetGameDialogState();
}

class _ResetGameDialogState extends State<ResetGameDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 5.0),
      shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.circular(16.0)),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Unfinnished Game!!',
            style: SlideTextStyle.instructions
                .copyWith(color: Colors.black, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(
                  text: "Are you sure you want to leave this game?",
                  style: SlideTextStyle.heading16.copyWith(
                      color: Colors.black.withOpacity(0.5), fontSize: 14),
                  children: [])),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'cancel',
                    style: SlideTextStyle.instructions
                        .copyWith(color: Colors.black, fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    widget.action();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'yes!',
                    style: SlideTextStyle.instructions
                        .copyWith(color: Colors.redAccent, fontSize: 18),
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class SDashtar extends StatefulWidget {
  const SDashtar({Key? key}) : super(key: key);

  @override
  _DashtarState createState() => _DashtarState();
}

class _DashtarState extends State<SDashtar> {
  SMIBool? dance;
  StateMachineController? controller;

  void init(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'birb');

    artboard.addController(controller!);
    dance = controller.findInput<bool>('dance') as SMIBool;
  }

  void dance42seconds() {
    if (dance?.value == false && mounted) {
      setState(() {
        dance?.value = true;
        Future.delayed(const Duration(seconds: 2), () {
          dance?.value = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dance42seconds();
    Timer.periodic(const Duration(seconds: 3), (t) {
      dance42seconds();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted && controller != null) controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      small: Transform.translate(
        offset: Offset(0, -MediaQuery.of(context).size.width * 0.5),
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.7,
          width: MediaQuery.of(context).size.width * 0.7,
          child: GestureDetector(
            onTap: () {
              dance42seconds();
            },
            child: RiveAnimation.asset(
              'assets/images/curriculum/games/slide/animations/birb.riv',
              onInit: init,
            ),
          ),
        ),
      ),
      medium: Transform.translate(
        offset: Offset(0, -MediaQuery.of(context).size.width * 0.3),
        child: GestureDetector(
          onTap: () {
            dance42seconds();
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
            child: RiveAnimation.asset(
              'assets/images/curriculum/games/slide/animations/birb.riv',
              onInit: init,
            ),
          ),
        ),
      ),
      large: GestureDetector(
        onTap: () {
          dance42seconds();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.width * 0.25,
          width: MediaQuery.of(context).size.width * 0.25,
          child: RiveAnimation.asset(
            'assets/images/curriculum/games/slide/animations/birb.riv',
            onInit: init,
          ),
        ),
      ),
    );
  }
}
