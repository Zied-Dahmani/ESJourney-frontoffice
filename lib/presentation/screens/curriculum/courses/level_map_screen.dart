import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:level_map/level_map.dart';

class LevelMapScreen extends StatelessWidget {
  const LevelMapScreen({Key? key, required this.grade}) : super(key: key);
  final int grade;

  @override
  Widget build(BuildContext context) {
    final height = ScreenSize.height(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LevelMap(
        key: const Key("level_map"),
        scrollToCurrentLevel: true,
        backgroundColor: Colors.blue,
        levelMapParams: LevelMapParams(
          dashLengthFactor: 0.05,
          enableVariationBetweenCurves: false,
          firstCurveReferencePointOffsetFactor: const Offset(1.0, 1.0),
          levelHeight: height * 0.3,
          pathStrokeWidth: 5,
          showPathShadow: true,
          shadowDistanceFromPathOffset: const Offset(-5, 20),
          levelCount: 6,
          currentLevel: grade.toDouble()+1,
          pathColor: Colors.white,
          currentLevelImage: ImageParams(
            path: "assets/images/curriculum/level_map/marker.png",
            size: const Size(60, 60),
          ),
          lockedLevelImage: ImageParams(
            path: "assets/images/curriculum/level_map/lock.png",
            size: const Size(40, 40),
          ),
          completedLevelImage: ImageParams(
            path: "assets/images/curriculum/level_map/ok.png",
            size: const Size(40, 40),
          ),
          startLevelImage: ImageParams(
            path: "assets/images/curriculum/level_map/start.png",
            size: const Size(200, 200),
          ),
          pathEndImage: ImageParams(
            path: "assets/images/curriculum/level_map/graduation.png",
            size: const Size(200, 200),
          ),
          bgImagesToBePaintedRandomly: [
            ImageParams(
              side: Side.LEFT,
              path: "assets/images/curriculum/level_map/Energy equivalency.png",
              size: const Size(80, 80),
              repeatCountPerLevel: 0.75,
            ),
            ImageParams(
              side: Side.RIGHT,
              path: "assets/images/curriculum/level_map/Certificate.png",
              size: const Size(80, 80),
              repeatCountPerLevel: 0.75,
            ),
          ],
        ),
      ),
    );
  }
}
