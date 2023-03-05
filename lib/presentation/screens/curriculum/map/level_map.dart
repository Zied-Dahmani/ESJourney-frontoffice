import 'package:avatar_glow/avatar_glow.dart';
import 'package:esjourney/utils/scroll_level.dart';
import 'package:flutter/material.dart';

class MapLevelScreen extends StatefulWidget {
  const MapLevelScreen({Key? key}) : super(key: key);

  @override
  State<MapLevelScreen> createState() => _MapLevelScreenState();
}

class _MapLevelScreenState extends State<MapLevelScreen> {
  @override
  Widget build(BuildContext context) {
    const imageCount = 4;
    const imageHeight = 2436.0 * imageCount;
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
                svgUrl:
                    "assets/images/curriculum/map/map_vertical.svg",
                points: List.generate(
                  1,
                  (index) => PointModel(
                    70,
                    const GameCourseItem(),
                    isCurrent: index == 0,
                  ),
                ),
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
                pointsPerImage: 5,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFEB4A5A),
              ),
              child: const Text(
                "Course Title",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GameCourseItem extends StatelessWidget {
  const GameCourseItem({Key? key}) : super(key: key);

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
          const Align(
            alignment: Alignment.center,
            child: Text(
              "C",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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

class GameStartEndItem extends StatelessWidget {
  const GameStartEndItem(
      {Key? key, required this.imagePath, required this.glowColor})
      : super(key: key);
  final String imagePath;
  final Color glowColor;

  @override
  Widget build(BuildContext context) {
    final startItem = SizedBox(
      child: Align(
        alignment: Alignment.center,
        child: Opacity(
          opacity: 1,
          child: Image.asset(
            imagePath,
          ),
        ),
      ),
    );

    return InkWell(
      child: AvatarGlow(
        glowColor: glowColor,
        endRadius: 40.0,
        child: startItem,
      ),
      onTap: () {},
    );
  }
}

class KGameLevelMapItem extends StatelessWidget {
  const KGameLevelMapItem({super.key});

  @override
  Widget build(BuildContext context) {
    final levelItem = SizedBox(
      height: 70,
      width: 70,
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
                "assets/images/curriculum/CourseMap/heroegg_without_space.png",
                width: 45,
                height: 45,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              child: Row(
                children: [
                  ...List.generate(
                    3,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  ...List.generate(
                    3 - 3,
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
    );

    return InkWell(
      child: AvatarGlow(
          glowColor: Colors.yellowAccent, endRadius: 40.0, child: levelItem),
      onTap: () {},
    );
  }
}
