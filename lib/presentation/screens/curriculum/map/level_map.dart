import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_levels_scrolling_map/game_levels_scrolling_map.dart';
import 'package:game_levels_scrolling_map/model/point_model.dart';

class MapLevelScreen extends StatefulWidget {
  const MapLevelScreen({Key? key}) : super(key: key);

  @override
  State<MapLevelScreen> createState() => _MapLevelScreenState();
}

class _MapLevelScreenState extends State<MapLevelScreen> {
  double? backgroundImageHeight;
  @override
  void initState() {
    super.initState();
    setupBackground();
  }

  setupBackground() async {
    final img = await rootBundle.load("assets/images/curriculum/map/map_vertical_infinity.png");
    final decodedImage = await decodeImageFromList(img.buffer.asUint8List());

    setState(() {
      backgroundImageHeight = double.tryParse(decodedImage.height.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    const imageCount = 10;
    return  LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GameLevelsScrollingMap.scrollable(
          backgroundImageWidget: Column(
            children: List.generate(
                imageCount, (index) => Image.asset("assets/images/curriculum/map/map_vertical_infinity.png")),
          ),
          imageUrl: "assets/images/curriculum/map/map_vertical_infinity.png",
          svgUrl: "assets/images/curriculum/map/map_vertical.svg",
          direction: Axis.vertical,
          imageHeight: backgroundImageHeight! * imageCount,
          reverseScrolling: false,
          width: constraints.maxWidth,
        );
      }
    );
  }
}
