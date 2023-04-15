import 'package:avatar_glow/avatar_glow.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/scroll_level.dart';
import 'package:flutter/material.dart';

class MapLevelScreen extends StatefulWidget {
  const MapLevelScreen({Key? key, required this.myCourses}) : super(key: key);
  final List<dynamic> myCourses;

  @override
  State<MapLevelScreen> createState() => _MapLevelScreenState();
}

class _MapLevelScreenState extends State<MapLevelScreen> {

  @override
  Widget build(BuildContext context) {
    final imageCount = widget.myCourses.length;
    final imageHeight = 2436.0 * imageCount;
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GameLevelsScrollingMap.scrollable(
                imageUrl:
                    "assets/images/curriculum/map/map_vertical_infinity.png",
                direction: Axis.vertical,
                reverseScrolling: true,
                svgUrl: "assets/images/curriculum/map/map_vertical.svg",
                points: [
                  for (var course in widget.myCourses) ...[
                    PointModel(70, GameCourseItem(courseTitle: course.title)),
                    PointModel(
                      70,
                      GameLevelMapItem(
                        isCompleted: false,
                        myRate: 0,
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.hangmanGame);
                        },
                      ),
                    ),
                    PointModel(70, GameQuizItem(onTap: () {})),
                  ]
                ],
                width: constraints.maxWidth,
                imageHeight: imageHeight,
                backgroundImageWidget: Column(
                  children: List.generate(
                    imageCount,
                    (index) => Image.asset(
                        "assets/images/curriculum/map/map_vertical_infinity.png"),
                  ),
                ),
                imageCount: imageCount,
                pointsPerImage: 6,
              );
            },
          ),
        ],
      ),
    );
  }
}

class GameLevelMapItem extends StatelessWidget {
  const GameLevelMapItem({super.key, required this.onTap,required this.isCompleted ,required this.myRate});

  final bool isCompleted ;
  final int myRate ;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    const lockedImage = "assets/images/curriculum/CourseMap/eggLocked.png";
    const unlockedImage = "assets/images/curriculum/CourseMap/eggUnlocked.png";
    final levelItem = SizedBox(
      height: 70,
      width: 70,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  "assets/images/curriculum/CourseMap/nest.png",
                  fit: BoxFit.fitWidth,
                  width: 70,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  isCompleted ? unlockedImage : lockedImage,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FittedBox(
                child: Row(
                  children: [
                    ...List.generate(
                      myRate,
                          (index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    ...List.generate(
                      3 - myRate,
                          (index) => const Icon(
                        Icons.star_border,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return InkWell(
      child: AvatarGlow(
          glowColor: Colors.yellowAccent, endRadius: 40.0, child: levelItem),
      onTap: () {},
    );
  }
}

class GameQuizItem extends StatelessWidget {
  const GameQuizItem({Key? key, required this.onTap}) : super(key: key);

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final quizItem = SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                  "assets/images/curriculum/CourseMap/question_ball.png"),
            ),
          ),
          const Align(
            alignment: Alignment.center,
            child: Text(
              "?",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: onTap,
      child: AvatarGlow(
        glowColor: Colors.lightBlue,
        endRadius: 40.0,
        child: quizItem,
      ),
    );
  }
}

class GameCourseItem extends StatelessWidget {
  const GameCourseItem({Key? key, required this.courseTitle}) : super(key: key);
  final String courseTitle;

  @override
  Widget build(BuildContext context) {
    final quizItem = SizedBox(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 1,
              child: Image.asset(
                  "assets/images/curriculum/CourseMap/course_ball.png"),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              courseTitle,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    return InkWell(
      child: AvatarGlow(
        glowColor: Colors.orangeAccent,
        endRadius: 40.0,
        child: quizItem,
      ),
      onTap: () {},
    );
  }
}
