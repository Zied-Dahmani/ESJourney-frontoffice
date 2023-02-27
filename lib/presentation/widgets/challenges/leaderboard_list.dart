import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';


class LeaderboardListView extends StatelessWidget {
  final List<LeaderboardRes> listItems;
  final int period;

  const LeaderboardListView({required this.listItems, required this.period});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return SizedBox(
      height: width * 1,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: listItems.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final score = period == 0
              ? listItems[index].score.weekly
              : period == 1
              ? listItems[index].score.monthly
              : listItems[index].score.allTime;
          return Container(
              margin: const EdgeInsets.fromLTRB(22.0, 0.0, 22.0, 15.0),
              height: width * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    width: width * 0.43,
                    margin: const EdgeInsets.only(left: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: width * 0.03,),
                        Text((index + 4).toString()),
                        SizedBox(
                          width: width * 0.03,),
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          backgroundImage: NetworkImage(
                              "https://api.readyplayer.me/v1/avatars/63ef772d12b893b896d44960.png"),

                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20.0, right: 5.0),
                            child: Text(
                              listItems[index].username,
                              style: const TextStyle(
                                fontFamily: 'visbyRoundCF',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // a text to the edge of the screen
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        score.toString(),
                        style: TextStyle(
                          color: theme.colorScheme.outline,
                          fontFamily: 'visbyRoundCF',
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
