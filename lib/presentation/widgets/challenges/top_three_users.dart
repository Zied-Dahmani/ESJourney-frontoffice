import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../data/models/challenges/leaderboard/leaderboard_res.dart';

class TopThreeUsers extends StatelessWidget {
  const TopThreeUsers({
    super.key, required this.leadberboardList, required this.period,

  });

  final List<LeaderboardRes> leadberboardList;
final int period;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);


    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [

          SizedBox(
            height: width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(height: width * 0.12),
                    Stack(
                      alignment: Alignment.lerp(Alignment.topCenter,
                          Alignment.bottomCenter, width * -0.0013)!,
                      children: [
                        Center(
                          child: Container(
                            width: width * 0.2,
                            height: width * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.2),
                              border: Border.all(
                                color: const Color(0xff3ED4A1),
                                width: 3,
                              ),
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  leadberboardList[1].twoDAvatar!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: width * 0.0108,
                          child: Container(
                            width: width * 0.05,
                            height: width * 0.05,
                            decoration: BoxDecoration(
                              color: const Color(0xff3ED4A1),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: const Center(
                              child: Text(
                                '2',
                                style: TextStyle(
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
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),

                    Text(
                      leadberboardList[1].username!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                    Text(
                     period == 0
                          ? leadberboardList[1].score.weekly.toString()
                          : period == 1
                          ? leadberboardList[1].score.monthly.toString()
                          : leadberboardList[1].score.allTime.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.lerp(Alignment.topCenter,
                          Alignment.bottomCenter, width * -0.003)!,
                      children: [
                        Center(
                          child: Container(
                            width: width * 0.3,
                            height: width * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.3),
                              border: Border.all(
                                color: const Color(0xffFFD000),
                                width: 3,
                              ),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  leadberboardList[0].twoDAvatar!,
                                ),

                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: width * 0.0158,
                          child: Container(
                            width: width * 0.05,
                            height: width * 0.05,
                            decoration: BoxDecoration(
                              color: const Color(0xffFFD000),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: const Center(
                              child: Text(
                                '1',
                                style: TextStyle(
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
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),

                    Text(
                      leadberboardList[0].username!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                    Text(   period == 0
                        ? leadberboardList[0].score.weekly.toString()
                        : period == 1
                        ? leadberboardList[0].score.monthly.toString()
                        : leadberboardList[0].score.allTime.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'VisbyRoundCF',
                          color: theme.colorScheme.outline,
                        )),
                  ],
                ),
                Column(
                  children: [
                    // crown icon
                    SizedBox(height: width * 0.12),

                    Stack(
                      alignment: Alignment.lerp(Alignment.topCenter,
                          Alignment.bottomCenter, width * -0.0013)!,
                      children: [
                        Center(
                          child: Container(
                            width: width * 0.2,
                            height: width * 0.2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.2),
                              border: Border.all(
                                color: const Color(0xffFF9F41),
                                width: 3,
                              ),
                            ),
                            child:  Padding(
                              padding: EdgeInsets.all(4.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
                                backgroundImage: NetworkImage(
                                  leadberboardList[2].twoDAvatar!,
                                ),

                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: width * 0.0108,
                          child: Container(
                            width: width * 0.05,
                            height: width * 0.05,
                            decoration: BoxDecoration(
                              color: const Color(0xffFF9F41),
                              borderRadius: BorderRadius.circular(width * 0.05),
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
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
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),

                    Text(
                      leadberboardList[2].username!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                    Text(
                      period == 0
                          ? leadberboardList[2].score.weekly.toString()
                          : period == 1
                          ? leadberboardList[2].score.monthly.toString()
                          : leadberboardList[2].score.allTime.toString(),
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
