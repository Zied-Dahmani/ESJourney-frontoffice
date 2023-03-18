import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/draw/model/game_room.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/draw/presentation/cubit/drawing_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankDrawerWidget extends StatelessWidget {
  const RankDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawingCubit, DrawingState>(
      builder: (context, state) {
        final orderedList =
            List.of(state.gameRoom?.connectedClients ?? <GamePlayer>[])
              ..sort(
                (a, b) {
                  return b.score?.compareTo(a.score ?? 0) ?? 0;
                },
              );
        return Drawer(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 32,
              left: 24,
              right: 24,
              bottom: 32,
            ),
            child: Column(
              children: [
                const Text(
                  "Ranking",
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderedList.length,
                    itemBuilder: (context, index) {
                      final player = orderedList[index];
                      return Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              player.username ?? "-",
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Score : ${player.score ?? 0}",
                            ),
                          ],
                        ),
                      );
                    },
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
