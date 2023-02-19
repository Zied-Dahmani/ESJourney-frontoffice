import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:esjourney/data/models/curriculum/course_model.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/curriculum/games/slide/tools/board_controller.dart';
import 'package:esjourney/presentation/widgets/curriculum/course_widget.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);
  final Course course;

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = ScreenSize.height(context);
    final double width = ScreenSize.width(context);
    List<Game> games = [
      Game(
        title: "Hangman",
        imagePath: "assets/images/curriculum/hangman.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.hangmanGame);
        },
      ),
      Game(
        title: "Jackpot",
        imagePath: "assets/images/curriculum/jackpot.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.jackpotGame);
        },
      ),
      Game(
        title: "Slide",
        imagePath: "assets/images/curriculum/jackpot.png",
        onTap: () {
          double swidth = MediaQuery.of(context).size.width * 0.8;
          if (width >= 425) {
            swidth = MediaQuery.of(context).size.width * 0.4;
          }
          if (width >= 1000) {
            swidth = MediaQuery.of(context).size.width * 0.28;
          }

          Provider.of<BoardController>(context, listen: false)
              .init(width: swidth);
          Navigator.of(context).pushNamed(AppRoutes.slideGame);
        },
      ),
      /*Game(
        title: "Sudoku",
        imagePath: "assets/images/curriculum/sudoku.png",
        onTap: () {
          print("sudoku");
          //Navigator.of(context).pushNamed(AppRoutes.jackpotGame);
        },
      ),*/
      Game(
        title: "Remember",
        imagePath: "assets/images/curriculum/memory.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.memoryGame);
        },
      ),
      Game(
        title: "Worldly",
        imagePath: "assets/images/curriculum/remember.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.wordlyGame);
        },
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 0.01 * height,
            right: 0.02 * width,
            left: 0.02 * width,
            bottom: 0.01 * height,
          ),
          //rounded corners
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0.08 * width),
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 0.015 * height,
                ),
                child: Text(
                  widget.course.module,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0.01 * height,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.av_timer_outlined,
                      color: Color(0xffEB4A5A),
                      size: 40,
                    ),
                    Text(
                      widget.course.estimatedTime,
                      style: const TextStyle(
                        color: Color(0xffEB4A5A),
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0.01 * height,
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: 100,
                  minRadius: 80,
                  backgroundImage:
                      AssetImage("assets/images/curriculum/hangman.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0.01 * height,
                ),
                child: Text(
                  widget.course.title,
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 0.01 * height,
                  bottom: 0.02 * height,
                ),
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 20,
                  animationDuration: 2000,
                  percent: 0.8,
                  center: const Text(
                    "80/100 XP",
                    style: TextStyle(color: Colors.white),
                  ),
                  progressColor: const Color(0xffEB4A5A),
                  barRadius: const Radius.circular(20),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 0.01 * height,
                    right: 0.01 * width,
                    left: 0.01 * width,
                  ),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverDynamicHeightGridView(
                        itemCount: games.length,
                        crossAxisCount: 2,
                        builder: (ctx, index) {
                          return CourseItem(
                            height: height,
                            width: width,
                            imagePath: games[index].imagePath,
                            courseTitle: games[index].title,
                            onTap: games[index].onTap,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffEB4A5A),
                  borderRadius: BorderRadius.circular(0.08 * width),
                ),
                padding: const EdgeInsets.all(6),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Quiz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Game {
  final String title;
  final String imagePath;
  final void Function() onTap;

  Game({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
}
