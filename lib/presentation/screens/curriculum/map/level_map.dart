import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';

class MapLevelScreen extends StatefulWidget {
  const MapLevelScreen({Key? key}) : super(key: key);

  @override
  State<MapLevelScreen> createState() => _MapLevelScreenState();
}

class _MapLevelScreenState extends State<MapLevelScreen> {
  @override
  Widget build(BuildContext context) {
    const imageCount = 1;
    const imageHeight = 2436.0 * imageCount;
    return Scaffold(
      body: Stack(
        children: [
          LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GameLevelsScrollingMap.scrollable(
              backgroundImageWidget: Column(
                children: List.generate(
                  imageCount,
                  (index) => Image.asset(
                    "assets/images/curriculum/map/map_vertical_infinity.png",
                  ),
                ),
              ),
              imageUrl:
                  "assets/images/curriculum/map/map_vertical_infinity.png",
              svgUrl: "assets/images/curriculum/map/map_vertical.svg",
              points: List.generate(
                10,
                (index) => PointModel(
                  70,
                  const KGameLevelMapItem(),
                  isCurrent: index == 0,
                ),
              ),
              direction: Axis.vertical,
              reverseScrolling: false,
              imageHeight: imageHeight,
              width: constraints.maxWidth,
            );
          }),
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
