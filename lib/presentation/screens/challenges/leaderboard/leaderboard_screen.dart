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

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}


final List<String> _listItems = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
];

List<LeaderboardRes> monthlyTop10 = [];
List<LeaderboardRes> weeklyTop10 = [];
List<LeaderboardRes> allTimeTop10 = [];




class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    //
    // final getLeaderboard = BlocProvider.of<LeaderboardCubit>(context);
    // getLeaderboard.getLeaderboard();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocBuilder<LeaderboardCubit, LeaderboardState>(
          builder: (context, state) {
        if (state is LeaderboardLoadInProgress) {
        } else if (state is LeaderboardSuccess) {
          return Column(
            children: [
              Stack(
                children: [
                  SvgPicture.asset(
                    'assets/icons/challenges/leaderboard.svg',
                    height: width * 1.035,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: width * 0.08,
                      ),
                      Center(
                        child: Text(
                          AppStrings.kleaderboard,
                          style: TextStyle(
                            color: theme.colorScheme.onPrimary,
                            fontSize: 25,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'VisbyRoundCF',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width * 0.03,
                      ),

                      LeaderboardHistory(
                          onThisWeekPressed: () {
                            BlocProvider.of<LeaderboardCubit>(context)
                                .changePeriod(0);
                          },
                          onMonthPressed: () {
                            BlocProvider.of<LeaderboardCubit>(context)
                                .changePeriod(1);
                          },
                          onAllTimePressed: () {
                            BlocProvider.of<LeaderboardCubit>(context)
                                .changePeriod(2);
                          },
                          buttonLabels: const [
                            "This week",
                            "Month",
                            "All time"
                          ]),

                      SvgPicture.asset(
                        'assets/icons/challenges/crown.svg',
                        width: width * 0.12,
                        height: width * 0.12,
                      )
                          .animate(
                        delay: 1000.ms,
                        // this delay only happens once at the very start
                        onPlay: (controller) => controller.repeat(), // loop
                      )
                          .shimmer(
                        delay: 1000.ms,
                        stops:
                            // from top left to bottom right
                            [0.0, 0.5, 1.0], // stops
                      ),
                      // this delay happens at the start of each loop

                      TopThreeUsers(
                        firstUsername: state.period == 0
                            ? state.weeklyUsers[0].username
                            : state.period == 1
                                ? state.monthlyUsers[0].username
                                : state.allTimeUsers[0].username,
                        firstUserScore: state.period == 0
                            ? state.weeklyUsers[0].score.weekly
                            : state.period == 1
                                ? state.monthlyUsers[0].score.monthly
                                : state.allTimeUsers[0].score.allTime,
                        secondUsername: state.period == 0
                            ? state.weeklyUsers[1].username
                            : state.period == 1
                                ? state.monthlyUsers[1].username
                                : state.allTimeUsers[1].username,
                        secondUserScore: state.period == 0
                            ? state.weeklyUsers[1].score.weekly
                            : state.period == 1
                                ? state.monthlyUsers[1].score.monthly
                                : state.allTimeUsers[1].score.allTime,
                        thirdUsername: state.period == 0
                            ? state.weeklyUsers[2].username
                            : state.period == 1
                                ? state.monthlyUsers[2].username
                                : state.allTimeUsers[2].username,
                        thirdUserScore: state.period == 0
                            ? state.weeklyUsers[2].score.weekly
                            : state.period == 1
                                ? state.monthlyUsers[2].score.monthly
                                : state.allTimeUsers[2].score.allTime,
                      )
                    ],
                  ),
                ],
              ),

              LeaderboardListView(
                listItems: state.period == 0
                    ? state.weeklyUsers.cast<LeaderboardRes>().sublist(3)
                    : state.period == 1
                        ? state.monthlyUsers.cast<LeaderboardRes>().sublist(3)
                        : state.allTimeUsers.cast<LeaderboardRes>().sublist(3),
                period: state.period,
              ),

              // LeaderboardListView()
            ],
          );
        } else if (state is LeaderboardIsFailure) {
          return const Center(child: CircularProgressIndicator());
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
