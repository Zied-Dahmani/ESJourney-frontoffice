import 'dart:async';
import 'dart:math';
import 'info.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/services.dart';
class ImageDetectionPage extends StatefulWidget {
  final double destinationLatitude;
  final double destinationLongitude;

  const ImageDetectionPage({
    Key? key,
    required this.destinationLatitude,
    required this.destinationLongitude,
  }) : super(key: key);
  @override
  _ImageDetectionPageState createState() => _ImageDetectionPageState();
}

enum WidgetDistance { ready, navigating }
enum WidgetCompass { scanning, directing }
enum TtsState { playing, stopped }

class _ImageDetectionPageState extends State<ImageDetectionPage> {
  WidgetDistance situationDistance = WidgetDistance.navigating;
  WidgetCompass situationCompass = WidgetCompass.directing;

  late ARKitController arkitController;
  bool anchorWasFound = false;
  late FlutterTts flutterTts;
  int _clearDirection = 0;
  double distance = 0;
  int _distance = 0;
  double targetDegree = 0;
  late Timer timer;
  TtsState ttsState = TtsState.stopped;

  //calculation formula of angel between 2 different points
  double angleFromCoordinate(
      double lat1, double long1, double lat2, double long2) {
    double dLon = (long2 - long1);

    double y = sin(dLon) * cos(lat2);
    double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    double brng = atan2(y, x);

    brng = vector.degrees(brng);
    brng = (brng + 360) % 360;
    //brng = 360 - brng; //remove to make clockwise
    return brng;
  }

  Future _speak() async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.0);

    if (_distance != 0) {
      var result =
          await flutterTts.speak('Distance of faculty is $_distance meters');
      if (result == 1) setState(() => ttsState = TtsState.playing);
    }
  }

  //device compass
  void calculateDegree() {
    FlutterCompass.events?.listen((CompassEvent event) {
      if (!mounted) return;
      setState(() {
        double? direction = event.heading;
        if (targetDegree != null && direction != null) {
          _clearDirection = targetDegree.truncate() - direction.truncate();
        }
      });
    });
  }



  //distance between faculty and device coordinates
  void _getlocation() async {
    // Check location permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permission denied');
        return;
      }
    }

    print('getting location');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    final double destinationLatitude = widget.destinationLatitude;
    final double destinationLongitude = widget.destinationLongitude;
    distance = await Geolocator.distanceBetween(position.latitude,
        position.longitude, destinationLatitude, destinationLongitude);

    targetDegree = angleFromCoordinate(position.latitude, position.longitude,
        destinationLatitude, destinationLongitude);
    calculateDegree();
  }

  @override
  void initState() {
    super.initState();
    print('ahawa');
    print(widget.destinationLatitude);
    print(widget.destinationLongitude);
    _getlocation(); //first run
    flutterTts = FlutterTts();
    timer = Timer.periodic(Duration(seconds: 7), (timer) {
      _getlocation();
      if (distance != null && distance >= 0 && distance < 50) {
        setState(() {
          situationDistance = WidgetDistance.ready;
          situationCompass = WidgetCompass.scanning;
        });
      } else {
        setState(() {
          _distance = distance?.truncate() ?? 0;
          situationDistance = WidgetDistance.navigating;
          situationCompass = WidgetCompass.directing;
        });
        _speak();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid calling `setState()` after the widget is disposed.
    arkitController.dispose();
    flutterTts.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('ESJourney '),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => CustomDialog());
              })
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color.fromARGB(190, 207, 37, 7),
                Colors.transparent
              ])),
        ),
      ),
      body: distanceProvider(),
      floatingActionButton: compassProvider());

  Widget readyWidget() {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
          ),
          anchorWasFound
              ? Container()
              : Column(
                  //do something here...
                  ),
        ],
      ),
    );
  }

  Widget navigateWidget() {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ARKitSceneView(
            detectionImagesGroupName: 'AR Resources',
            onARKitViewCreated: onARKitViewCreated,
          ),
          anchorWasFound
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(' Distance of Faculty : $_distance m.',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              backgroundColor: Colors.blueGrey,
                              color: Colors.white)),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget scanningWidget() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: null,
      child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove_red_eye),
            color: Colors.white,
            onPressed: () {},
          )),
    );
  }

  Widget directingWidget() {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: null,
      child: RotationTransition(
        turns: AlwaysStoppedAnimation(_clearDirection > 0
            ? _clearDirection / 360
            : (_clearDirection + 360) / 360),
        //if you want you can add animation effect for rotate
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.lightBlue,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_upward),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
      ),
    );
  }

  Widget compassProvider() {
    switch (situationCompass) {
      case WidgetCompass.scanning:
        return scanningWidget();
      case WidgetCompass.directing:
        return directingWidget();
    }
    return directingWidget();
  }

  Widget distanceProvider() {
    switch (situationDistance) {
      case WidgetDistance.ready:
        return readyWidget();
      case WidgetDistance.navigating:
        return navigateWidget();
    }
    return navigateWidget();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = onAnchorWasFound;
  }

  void onAnchorWasFound(ARKitAnchor anchor) {
    if (anchor is ARKitImageAnchor) {
      //if you want to block AR while you aren't close to target > add "if (situationDistance==WidgetDistance.ready)" here
      setState(() => anchorWasFound = true);

      final materialCard = ARKitMaterial(
        lightingModelName: ARKitLightingModel.lambert,
        diffuse: ARKitMaterialProperty.image('assets/images/Pinned.png'),
      );

      final image =
      ARKitPlane(height: 0.4, width: 0.4, materials: [materialCard]);

      final targetPosition = anchor.transform.getColumn(3);
      final node = ARKitNode(
        geometry: image,
        position: vector.Vector3(
            targetPosition.x, targetPosition.y, targetPosition.z),
        eulerAngles: vector.Vector3.zero(),
      );
      arkitController.add(node);
    }
  }
}
