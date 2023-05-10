
import 'package:flutter/material.dart';

import '../../../utils/screen_size.dart';
class TopUsersStack extends StatelessWidget {
  const TopUsersStack({
    super.key,
    required this.width,
    required this.rank,
    required this.color, required this.rankPosition, required this.userAvatar,
  });


  final double width;
  final int rank;
  final Color color;
  final double rankPosition ;
  final String  userAvatar;
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
            child:  Padding(
              padding: const EdgeInsets.all(4.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: NetworkImage(
                    userAvatar
                ),
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
class TopThreeUsersHomePage extends StatelessWidget {
  const TopThreeUsersHomePage({
    super.key,
    required this.username,
    this.userAvatar,
  });

  final List<String> username;
  final List<String>? userAvatar;

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
                    userAvatar: userAvatar![0],
                  ),

                  SizedBox(
                    height: width * 0.02,
                  ),

                  Text(
                    username[0],
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
                    userAvatar: userAvatar![0],
                  ),

                  SizedBox(
                    height: width * 0.02,
                  ),

                  Text(
                    username[1],
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
                    userAvatar: userAvatar![2],
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  Text(
                    username[2],
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