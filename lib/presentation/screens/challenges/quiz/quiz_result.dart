import 'dart:math';
import 'dart:ui';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_svg/svg.dart';


class QuizResultScreen extends StatefulWidget {
  final int score;

  QuizResultScreen({required this.score});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    bool isCompleted = true;
    //  widget.score >= 2;
    print("score is ${widget.score}");

    double randomNumber = Random().nextInt(5000) + 5000;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: width * 0.5,
                  width: width * 0.5,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isCompleted
                              ? theme.colorScheme.outline.withOpacity(0.1)
                              : theme.colorScheme.primary.withOpacity(0.1),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: width * 0.4,
                  width: width * 0.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? theme.colorScheme.outline
                        : theme.colorScheme.primary,
                  ),
                  child: Center(
                    child: Icon(
                      isCompleted ? Icons.check : Icons.close,
                      color: theme.colorScheme.onPrimary,
                      size: 100,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(isCompleted ? "Congratulations!" : "Oops!",
                style: TextStyle(
                  fontFamily: 'VisbyRoundCF',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.outline,
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: randomNumber, end: 0.2),
                      builder: (context, value, child) {
                        final percent = value.toStringAsFixed(2);
                        return Text(
                          'You earned $percent coins ',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                      duration: const Duration(milliseconds: 1500),
                    ),
                    SvgPicture.network(
                      "http://192.168.0.12:3030/img/1680451548823.svg",
                      height: width * 0.1,
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
                    Visibility(
                      visible: !isCompleted,
                      child: Text("Keep practicing to improve your skills!",
                          style: TextStyle(
                            fontFamily: 'VisbyRoundCF',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.secondary,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text("Your Score",
                style: TextStyle(
                  fontFamily: 'VisbyRoundCF',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.outline,
                )),
            SizedBox(
              height: height * 0.01,
            ),
            Text("${widget.score}/10",
                style: TextStyle(
                  fontFamily: 'VisbyRoundCF',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.secondary,
                )),
            SizedBox(
              height: height * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuizResultOption(
                  theme: theme,
                  icon: Icons.home_outlined,
                  text: "Home",
                  width: width,
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(AppRoutes.zoomDrawerScreen);
                  },
                ),
                if (!isCompleted)
                  QuizResultOption(
                    theme: theme,
                    icon: Icons.refresh_outlined,
                    text: "Try Again",
                    width: width,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.quizScreen, arguments: true);
                    },
                  ),
                if (isCompleted)
                  QuizResultOption(
                    theme: theme,
                    icon: Icons.remove_red_eye_outlined,
                    text: "Review",
                    width: width,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.quizScreen, arguments: false);
                    },
                  ),
                if (isCompleted)
                  QuizResultOption(
                    theme: theme,
                    icon: Icons.leaderboard_outlined,
                    text: "Leaderboard",
                    width: width,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.leaderboardScreen);
                    },
                  ),
                if (isCompleted)
                  QuizResultOption(
                    theme: theme,
                    icon: Icons.share,
                    text: "Share",
                    width: width,
                    onTap: () {
                      sharePressed();
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> sharePressed() async {
  String msg =
      "I just won my first quiz on the Quiz app and I'm feeling on top of the world!"
      " 🎉🎊🥳 It's an awesome feeling to test my knowledge and be rewarded for it with"
      " some crypto coins. If you're up for a challenge, download the Quiz app and see at "
      "https.//esjourney.page.link/iGuj "
      " if you can beat my score! #quiz #knowledgeispower #crypto";
  String url = 'https.//esjourney.page.link/iGuj';

  String? response;
  final FlutterShareMe flutterShareMe = FlutterShareMe();
  response = await flutterShareMe.shareToSystem(msg: msg);
}

class QuizResultOption extends StatelessWidget {
  const QuizResultOption({
    super.key,
    required this.theme,
    required this.icon,
    required this.text,
    required this.width,
    this.onTap,
  });

  final ThemeData theme;

  final double width;
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: width * 0.2, height: width * 0.2, // circular border
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(
                  width * 0.2,
                ),
              ),

              child: Center(
                child: Icon(
                  icon,
                  color: theme.colorScheme.background,
                  size: width * 0.08,
                ),
              ),
            ),
          ),
          SizedBox(
            height: width * 0.03,
          ),
          Text(text,
              style: TextStyle(
                fontFamily: 'VisbyRoundCF',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.secondary,
              ))
        ],
      );
}
