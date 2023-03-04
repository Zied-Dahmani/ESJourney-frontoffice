import 'package:flutter/material.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';

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
      body: LayoutBuilder(
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
          imageUrl: "assets/images/curriculum/map/map_vertical_infinity.png",
          svgUrl: "assets/images/curriculum/map/map_vertical.svg",
          direction: Axis.vertical,
          reverseScrolling: false,
          imageHeight: imageHeight,
          width: constraints.maxWidth,
        );
      }),
    );
  }
}
