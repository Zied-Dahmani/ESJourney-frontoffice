import 'dart:async';

import 'package:esjourney/presentation/screens/curriculum/games/draw/core/bloc/user_cubit/drawer_cubit.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/draw/model/drawing_point.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/draw/presentation/cubit/drawing_cubit.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/draw/presentation/widget/rank_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawingRoomScreen extends StatelessWidget {
  const DrawingRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final username = context.read<DrawerCubit>().state.username;
    return BlocProvider(
      create: (context) => DrawingCubit(
        id: id,
        username: username,
      ),
      child: const DrawingRoom(),
    );
  }
}

class DrawingRoom extends StatefulWidget {
  const DrawingRoom({super.key});

  @override
  State<DrawingRoom> createState() => _DrawingRoomState();
}

class _DrawingRoomState extends State<DrawingRoom> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isPauseDialogOpen = false;
  String username = "";

  Duration defaultDuration = const Duration(seconds: 30);
  Timer? timer;
  Duration currentDuration = Duration.zero;

  @override
  void initState() {
    username = context.read<DrawerCubit>().state.username;
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  void startTimer({bool startOver = true}) {
    if (timer != null) return;

    if (startOver) {
      currentDuration = defaultDuration;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDuration -= const Duration(seconds: 1);
      context.read<DrawingCubit>().playerTicker(currentDuration.inSeconds);
      if (currentDuration.inSeconds == 0) {
        context.read<DrawingCubit>().playerTimeout();
        stopTimer();
      }
    });
  }

  void stopTimer() {
    if (timer == null) return;

    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DrawingCubit, DrawingState>(
          listenWhen: (previous, current) {
            return previous.gameRoom?.isPlaying != current.gameRoom?.isPlaying;
          },
          listener: (context, state) async {
            if (state.gameRoom?.isPlaying == false) {
              stopTimer();
              isPauseDialogOpen = true;
              final result = await showWaitingDialog(
                context,
              ) as bool?;
              if (result == true) {
                if (!mounted) return;
                Navigator.pop(context);
              }
            } else {
              if (state.gameRoom?.currentPlayer?.username == username) {
                startTimer();
              }
              if (isPauseDialogOpen) {
                isPauseDialogOpen = false;
                Navigator.pop(context);
              }
            }
          },
        ),
        BlocListener<DrawingCubit, DrawingState>(
          listenWhen: (previous, current) {
            final currentLength =
                current.gameRoom?.connectedClients?.length ?? 0;
            final previousLength =
                previous.gameRoom?.connectedClients?.length ?? 0;
            return currentLength > previousLength;
          },
          listener: (context, state) {
            context
                .read<DrawingCubit>()
                .notifyFromSysteminChat("A Player has Join the Game");
          },
        ),
        BlocListener<DrawingCubit, DrawingState>(
          listenWhen: (previous, current) {
            final currentLength =
                current.gameRoom?.connectedClients?.length ?? 0;
            final previousLength =
                previous.gameRoom?.connectedClients?.length ?? 0;
            return currentLength < previousLength;
          },
          listener: (context, state) {
            context
                .read<DrawingCubit>()
                .notifyFromSysteminChat("A Player has Left the Game");
          },
        ),
        BlocListener<DrawingCubit, DrawingState>(
          listenWhen: (previous, current) {
            return previous.gameRoom?.currentPlayer !=
                current.gameRoom?.currentPlayer;
          },
          listener: (context, state) {
            context.read<DrawingCubit>().notifyFromSysteminChat(
                  "${state.gameRoom?.currentPlayer?.username} turn to Draw",
                );

            if (state.gameRoom?.currentPlayer?.username == username) {
              if (state.gameRoom?.isPlaying == true) {
                startTimer();
              }
            } else {
              stopTimer();
            }
          },
        ),
      ],
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: const RankDrawerWidget(),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: const DrawingCanvas(),
            ),
            BlocBuilder<DrawingCubit, DrawingState>(
              builder: (context, state) {
                return Positioned(
                  top: MediaQuery.of(context).padding.top + 24,
                  left: 16,
                  right: 0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FloatingActionButton(
                        heroTag: "Back",
                        backgroundColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:
                            const Icon(Icons.chevron_left, color: Colors.black),
                      ),
                      const Spacer(),
                      if (state.gameRoom?.currentPlayer?.username ==
                          username) ...[
                        FloatingActionButton(
                          heroTag: "Undo",
                          backgroundColor: Colors.white,
                          onPressed: context.read<DrawingCubit>().undoDrawing,
                          child: const Icon(Icons.undo, color: Colors.black),
                        ),
                        const SizedBox(width: 16),
                        FloatingActionButton(
                          heroTag: "Redo",
                          backgroundColor: Colors.white,
                          onPressed: context.read<DrawingCubit>().redoDrawing,
                          child: const Icon(Icons.redo, color: Colors.black),
                        ),
                      ],
                      const SizedBox(width: 16),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {
                              scaffoldKey.currentState?.openEndDrawer();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(32),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.scoreboard,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          BlocBuilder<DrawingCubit, DrawingState>(
                            buildWhen: (previous, current) {
                              return previous.gameRoom?.currentDuration !=
                                  current.gameRoom?.currentDuration;
                            },
                            builder: (context, state) {
                              final duration =
                                  state.gameRoom?.currentDuration ?? 0;
                              final textDuration =
                                  duration < 10 ? "0$duration" : "$duration";
                              return Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xFFEB4A5A),
                                    width: 2,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  textDuration,
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<T?> showWaitingDialog<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.white,
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: CircularProgressIndicator(
                    color: Color(0xFFEB4A5A),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 8,
                  ),
                  child: Text(
                    "Waiting for Players",
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 8,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DrawingCanvas extends StatefulWidget {
  const DrawingCanvas({super.key});

  @override
  State<DrawingCanvas> createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  final textController = TextEditingController();
  String username = "";

  @override
  void initState() {
    username = context.read<DrawerCubit>().state.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 100,
          child: BlocBuilder<DrawingCubit, DrawingState>(
            builder: (context, state) {
              return GestureDetector(
                onPanStart: (details) {
                  if (state.gameRoom?.currentPlayer?.username == username) {
                    context
                        .read<DrawingCubit>()
                        .onPanStart(offset: details.localPosition);
                  }
                },
                onPanUpdate: (details) {
                  if (state.gameRoom?.currentPlayer?.username == username) {
                    context
                        .read<DrawingCubit>()
                        .onPanUpdate(offset: details.localPosition);
                  }
                },
                onPanEnd: (_) {
                  if (state.gameRoom?.currentPlayer?.username == username) {
                    context.read<DrawingCubit>().onPanEnd();
                  }
                },
                child: CustomPaint(
                  painter: DrawingPainter(
                    drawingPoints: state.drawingPoints,
                  ),
                  child: Container(),
                ),
              );
            },
          ),
        ),
        Expanded(
          flex: 30,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFEB4A5A),
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: BlocBuilder<DrawingCubit, DrawingState>(
                      buildWhen: (previous, current) {
                        return previous.answers.length !=
                            current.answers.length;
                      },
                      builder: (context, state) {
                        return ListView.separated(
                          reverse: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: state.answers.length,
                          separatorBuilder: (_, __) {
                            return const Divider(
                              height: 2,
                              thickness: 1,
                            );
                          },
                          itemBuilder: (context, index) {
                            final data = state.answers[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "${data.username} : ",
                                      style: const TextStyle(
                                        color: Color(0xFFEB4A5A),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data.answer,
                                      style: TextStyle(
                                        color: data.isSystem
                                            ? Colors.black
                                            : data.isCorrect
                                                ? Colors.green
                                                : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                BlocBuilder<DrawingCubit, DrawingState>(
                  builder: (context, state) {
                    if (state.gameRoom?.currentPlayer?.username == username) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEB4A5A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                            "Its your turn, draw a \"${state.gameRoom?.currentAnswer ?? ""}\"",
                            style: const TextStyle(color: Colors.white)),
                      );
                    }
                    if (state.gameRoom?.connectedClients
                            ?.firstWhere((e) => e.username == username)
                            .isAnswered ==
                        true) {
                      return const SizedBox();
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                        controller: textController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 0,
                          ),
                          border: InputBorder.none,
                          hintText: "Answer here",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          textController.clear();
                          context.read<DrawingCubit>().sendAnswer(value);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPoint> drawingPoints;

  DrawingPainter({required this.drawingPoints});

  final _paint = Paint()
    ..color = Colors.black
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    for (var drawingPoint in drawingPoints) {
      for (var i = 0; i < drawingPoint.offsets.length; i++) {
        var notLastOffset = i != drawingPoint.offsets.length - 1;

        if (notLastOffset) {
          final current = drawingPoint.offsets[i];
          final next = drawingPoint.offsets[i + 1];
          canvas.drawLine(
            Offset(current.dx, current.dy),
            Offset(next.dx, next.dy),
            _paint,
          );
        } else {
          // do Nothing
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
