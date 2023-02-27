import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TopThreeUsers extends StatelessWidget {
  const TopThreeUsers({
    super.key,
    this.firstUserImage,
    required this.firstUsername,
    required this.firstUserScore,
    this.secondUserImage,
    required this.secondUsername,
    required this.secondUserScore,
    this.thirdUserImage,
    required this.thirdUsername,
    required this.thirdUserScore,
  });

  final String firstUsername;

  final String secondUsername;

  final String thirdUsername;
  final Image? firstUserImage;
  final Image? secondUserImage;
  final Image? thirdUserImage;
  final double firstUserScore;

  final double secondUserScore;

  final double thirdUserScore;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/challenges/crown.svg',
            width: width * 0.12,
            height: width * 0.12,
          ),
          SizedBox(
            height: width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                                color: const Color(0xff3ED4A1),
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
                      secondUsername,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                    Text(
                      secondUserScore.toString(),
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
                    // crown icon
                    //

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
                      firstUsername,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                    Text(firstUserScore.toString(),
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
                      thirdUsername,
                      style: const TextStyle(
                        fontSize: 13,
                        fontFamily: 'VisbyRoundCF',
                      ),
                    ),
                    Text(
                      thirdUserScore.toString(),
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