import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_state.dart';
import 'package:esjourney/presentation/widgets/challenges/leaderboard_history.dart';
import 'package:esjourney/presentation/widgets/challenges/leaderboard_list.dart';
import 'package:esjourney/presentation/widgets/challenges/top_three_users.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    );
  }
}

class TopThreeUsersHomePage extends StatelessWidget {
  const TopThreeUsersHomePage({
    super.key,
    this.firstUserImage,
    required this.firstUsername,
    this.secondUserImage,
    required this.secondUsername,
    this.thirdUserImage,
    required this.thirdUsername,
  });

  final String firstUsername;

  final String secondUsername;

  final String thirdUsername;
  final Image? firstUserImage;
  final Image? secondUserImage;
  final Image? thirdUserImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  // crown icon

                  TopUsersStack(
                    width: width * 1.06,
                    color: const Color(0xff3C4150),
                    rank: 1,
                    rankPosition: 0.0101,
                  ),

                  SizedBox(
                    height: width * 0.02,
                  ),

                  Text(
                    secondUsername,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'VisbyRoundCF',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  // crown icon
                  //
                  TopUsersStack(
                    width: width,
                    color: const Color(0xff00919E),
                    rank: 2,
                    rankPosition: 0.0108,
                  ),

                  SizedBox(
                    height: width * 0.02,
                  ),

                  Text(
                    firstUsername,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'VisbyRoundCF',
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  TopUsersStack(
                    width: width * 0.9,
                    color: const Color(0xff2CBA9E),
                    rank: 3,
                    rankPosition: 0.01199,
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  Text(
                    thirdUsername,
                    style: const TextStyle(
                      fontSize: 13,
                      fontFamily: 'VisbyRoundCF',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopUsersStack extends StatelessWidget {
  const TopUsersStack({
    super.key,
    required this.width,
    required this.rank,
    required this.color, required this.rankPosition,
  });

  final double width;
  final int rank;
  final Color color;
  final double rankPosition ;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.lerp(
          Alignment.topCenter, Alignment.bottomCenter, width * -0.0013)!,
      children: [
        Center(
          child: Container(
            width: width * 0.2,
            height: width * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.2),
              border: Border.all(
                color: color,
                width: 3,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://api.readyplayer.me/v1/avatars/63ef772d12b893b896d44960.png"),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          heightFactor: width * rankPosition,
          child: Container(
            width: width * 0.05,
            height: width * 0.05,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width * 0.05),
            ),
            child: Center(
              child: Text(
                rank.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'VisbyRoundCF',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
