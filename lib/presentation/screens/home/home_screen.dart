import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_state.dart';
import 'package:esjourney/presentation/widgets/challenges/top-three_users_homepage.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<LeaderboardRes> allTimeTop3 = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: SingleChildScrollView(
          child: BlocBuilder<LeaderboardCubit, LeaderboardState>(
              builder: (context, state) {
            if (state is LeaderboardLoadInProgress) {
            } else if (state is LeaderboardSuccess) {
              return Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          const Center(
                            child: Text(
                              'TOP 3',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontFamily: 'VisbyRoundCF',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: width * 0.03,
                          ),

                          // this delay happens at the start of each loop

                          TopThreeUsersHomePage(
                            firstUsername: state.allTimeUsers[0].username,
                            secondUsername: state.allTimeUsers[1].username,
                            thirdUsername: state.allTimeUsers[2].username,
                          )
                        ],
                      ),
                    ],
                  ),

                  // LeaderboardListView()
                ],
              );
            } else if (state is LeaderboardIsFailure) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(child: CircularProgressIndicator());
          }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.colorScheme.primary,
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ));
  }
}
