import 'dart:async';
import 'dart:ui' as ui show Image;

import 'package:esjourney/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class Q extends Object {
  static String TAG = "[COIMAGE]";
  static double deviceWidth = 0;
  static double deviceHeight = 0;
}

class PointModel {
  double? width;
  Widget? child;
  String? levelIcon;
  bool? isCurrent;

  PointModel(this.width, this.child, {this.isCurrent = false, this.levelIcon});

  PointModel.fromJson(Map<String, dynamic> json) {
    width = json['Width'];
    child = json['Child'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Width'] = width;
    data['Child'] = child;
    return data;
  }
}

class LoadingProgress extends StatelessWidget {
  const LoadingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        color: Colors.black38,
        width: double.infinity,
        height: 150,
        child: Center(
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: SizedBox(
                height: 70,
                width: 70,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GameLevelsScrollingMap extends StatefulWidget {
  double? height;
  double? width;

  double? imageHeight;
  double? imageWidth;

  double? currentPointDeltaY;
  String imageUrl;
  String? svgUrl = "";

  List<double>? x_values = [];
  List<double>? y_values = [];

  List<PointModel>? points = [];

  double? pointsPositionDeltaX = 0;
  double? pointsPositionDeltaY = 0;

  int? pointsPerImage = 1;
  int? imageCount = 0;

  bool isScrollable = false;
  Axis? direction = Axis.horizontal;
  bool? reverseScrolling = false;

  Widget? backgroundImageWidget;

  GameLevelsScrollingMap({
    this.imageUrl = "",
    required this.width,
    required this.height,
    this.imageWidth,
    this.imageHeight,
    this.svgUrl,
    this.points,
    this.x_values,
    this.y_values,
    this.pointsPositionDeltaX,
    this.pointsPositionDeltaY,
    this.currentPointDeltaY,
    this.backgroundImageWidget,
    this.pointsPerImage,
    this.imageCount,
    Key? key,
  }) : super(key: key);

  GameLevelsScrollingMap.scrollable({
    this.imageUrl = "",
    this.width,
    this.height,
    this.imageWidth,
    this.imageHeight,
    this.direction,
    this.currentPointDeltaY,
    this.svgUrl,
    this.points,
    this.x_values,
    this.y_values,
    this.pointsPositionDeltaX,
    this.pointsPositionDeltaY,
    this.reverseScrolling,
    this.backgroundImageWidget,
    this.pointsPerImage,
    this.imageCount,
    Key? key,
  }) : super(key: key) {
    isScrollable = true;
  }

  @override
  _GameLevelsScrollingMapState createState() => _GameLevelsScrollingMapState();
}

class _GameLevelsScrollingMapState extends State<GameLevelsScrollingMap> {
  List<double>? newX_values = [];
  List<double>? newY_values = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initDeviceDimensions();
      initDefaults();

      if (widget.svgUrl!.isNotEmpty) {
        await _getPathFromSVG();
      }
      await _loadImage(path: widget.imageUrl);
      if (widget.isScrollable) {
        int currentIndex =
            widget.points!.indexWhere((point) => point.isCurrent!);
        if (widget.direction == Axis.horizontal) {
          if (currentIndex != -1 && newX_values!.isNotEmpty) {
            _scrollController.animateTo(newX_values![currentIndex],
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeIn);
          }
        } else {
          if (currentIndex != -1 && newY_values!.isNotEmpty) {
            _scrollController.animateTo(newY_values![currentIndex],
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeIn);
          }
        }
      }
    });
  }

  void initDeviceDimensions() {
    Q.deviceWidth = MediaQuery.of(context).size.width;
    Q.deviceHeight = MediaQuery.of(context).size.height;
  }

  void initDefaults() {
    widget.svgUrl ??= "";
    widget.x_values ??= [];
    widget.y_values ??= [];
    widget.points ??= [];
    widget.pointsPositionDeltaX ??= 0;
    widget.pointsPositionDeltaY ??= 0;
    widget.direction ??= Axis.horizontal;
    widget.reverseScrolling ??= false;
    widget.height ??= Q.deviceHeight;
    if (widget.direction == Axis.vertical) {
      widget.width ??= Q.deviceWidth;
    } else if (widget.direction == Axis.horizontal) {
      widget.width ??= 0;
    }
    if (widget.width == double.infinity) {
      widget.width = Q.deviceWidth;
    }
  }

  final _scrollController = ScrollController();
  final _key = GlobalKey();
  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        key: widget.key ?? _key,
        // color: Colors.red,
        width: widget.width != 0 ? widget.width : maxWidth,
        height: maxHeight,
        child: widget.isScrollable
            ? SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: _scrollController,
                scrollDirection: widget.direction ?? Axis.horizontal,
                reverse: widget.reverseScrolling ?? false,
                child: aspectRatioWidget(),
              )
            : aspectRatioWidget());
  }

  Widget aspectRatioWidget() {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return imageWidth != 0
              ? Stack(
                  textDirection: TextDirection.ltr,
                  alignment: AlignmentDirectional.topStart,
                  children: widgets,
                )
              : const LoadingProgress();
        },
      ),
    );
  }

  bool isImageLoaded = false;

  double aspectRatio = 1;
  double imageWidth = 0;
  double imageHeight = 0;
  double maxWidth = 0;
  double maxHeight = 0;

  Completer<ui.Image> completer = Completer<ui.Image>();
  ImageStream? stream;
  ImageStreamListener? listener;

  Future<ui.Image> _loadImage({String path = ""}) async {
    if (path.isEmpty) {
      imageStreamListenerCallBack();
    } else {
      if (path.contains("assets")) {
        stream = AssetImage(path).resolve(ImageConfiguration.empty);
      } else {
        stream = NetworkImage(path).resolve(ImageConfiguration.empty);
      }

      listener = ImageStreamListener((ImageInfo frame, bool synchronousCall) {
        imageStreamListenerCallBack(
            frame: frame, synchronousCall: synchronousCall);
      });

      stream?.addListener(listener!);
    }
    return completer.future;
  }

  ui.Image? image;

  void imageStreamListenerCallBack({ImageInfo? frame, bool? synchronousCall}) {
    if (frame != null) {
      image = frame.image;
    }
    imageWidth = widget.imageWidth ?? image!.width.toDouble();
    imageHeight = widget.imageHeight ?? image!.height.toDouble();

    aspectRatio = imageWidth / imageHeight;

    if (widget.isScrollable) {
      if (widget.direction == Axis.horizontal) {
        maxHeight = widget.height!;
        maxWidth = maxHeight * aspectRatio;
      } else if (widget.direction == Axis.vertical) {
        maxWidth = widget.width!;
        maxHeight = maxWidth / aspectRatio;
      }
    } else {
      maxWidth = widget.width!;
      maxHeight = widget.height!;
      aspectRatio = widget.width! / widget.height!;
    }

    widgets.add(backgroundImage());
    drawPoints();

    if (image != null) {
      completer.complete(image);
      stream?.removeListener(listener!);
    }

    setState(() => {});
  }

  Widget backgroundImage() {
    return Container(
      height: maxHeight,
      width: maxWidth,
      color: Colors.red,
      child: imageWidth != 0
          ? widget.backgroundImageWidget ??
              (widget.imageUrl.contains("assets")
                  ? Image.asset(widget.imageUrl,
                      fit: BoxFit.fill, filterQuality: FilterQuality.high)
                  : Image.network(widget.imageUrl,
                      fit: BoxFit.fill, filterQuality: FilterQuality.high))
          : const LoadingProgress(),
    );
  }

  void drawPoints() {
    double halfScreenWidth = (MediaQuery.of(context).size.width) / 2;
    double halfScreenHeight = (MediaQuery.of(context).size.height) / 2;

    for (int i = 0; i < widget.points!.length; i++) {
      //widget.points!.add(PointModel(100, testWidget(i)));
      if (widget.x_values!.length > i) {
        var x = (widget.x_values![i] * maxWidth / imageWidth) +
            widget.pointsPositionDeltaX!;

        x = x - (widget.points![i].width! / 2);
        newX_values!.add((x - halfScreenWidth).abs());

        var y = ((widget.y_values![i] * maxHeight / imageHeight) +
            widget.pointsPositionDeltaY!);
        if (widget.points![i].isCurrent! && widget.currentPointDeltaY != null) {
          y = y - widget.currentPointDeltaY!;
        }
        y = y - (widget.points![i].width! / 2);
        newY_values!.add((y - halfScreenHeight).abs());

        widgets.add(pointWidget(x, y, child: widget.points![i].child));
      } else {
        break;
      }
    }
  }

  Widget pointWidget(double x, double y, {Widget? child}) {
    return Positioned(left: x, top: y, child: child ?? Container());
  }

  Future _getPathFromSVG() async {
    await getPointsPathFromXML().then((value) {
      if (widget.points == null ||
          widget.pointsPerImage == null ||
          widget.imageCount == null ||
          widget.imageHeight == null) return;

      List<List<String>>? svgPoints =
          value.split(" ").map((String item) => item.split(",")).toList();
      for (int i = 0; i < widget.points!.length; i++) {
        int currentImageIndex = widget.pointsPerImage! > 0
            ? (i / widget.pointsPerImage!).floor()
            : i;
        List<String> originPoint = svgPoints[i % svgPoints.length];
        widget.x_values!.add(double.parse(originPoint[0]));
        widget.y_values!.add(double.parse(originPoint[1]) +
            (widget.imageHeight! / widget.imageCount!) *
                (widget.imageCount! - currentImageIndex - 1));
      }
    });
  }

  Future<String> getPointsPathFromXML() async {
    String path = "";
    XmlDocument x = await Utils.readSvg(widget.svgUrl!);
    Utils.getXmlWithClass(x, "st0").forEach((element) {
      path = element.getAttribute("points")!;
    });
    return path;
  }
}
