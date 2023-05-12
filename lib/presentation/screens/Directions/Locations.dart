import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'detect.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({Key? key}) : super(key: key);

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final _destinations = [
    Destination(name: 'Bloc G', imageUrl: 'assets/images/Logo_ESPRIT_Ariana.jpg', latitude: 36.89877138293219, longitude: 10.189069059858745),
    Destination(name: 'Bloc E', imageUrl: 'assets/images/Logo_ESPRIT_Ariana.jpg', latitude: 36.8996143056227, longitude: 10.189819348195497),
    Destination(name: 'Bloc H', imageUrl: 'assets/images/logo-esb.png', latitude: 36.8979926492164, longitude: 10.189644899020355),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Esprit Locations',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.bars,
            color: Colors.black,
          ),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
          },
        ),
      ),

      body: ListView.builder(
        itemCount: _destinations.length,
        itemBuilder: (context, index) {
          final destination = _destinations[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    destination.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    destination.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageDetectionPage(
                        destinationLatitude: destination.latitude,
                        destinationLongitude: destination.longitude,
                      ),
                    ));
                  },
                  icon: Icon(Icons.directions, color: Colors.blueGrey),
                  label: Text(
                    'Directions',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Destination {
  final String name;
  final String imageUrl;
  final double latitude;
  final double longitude;

  Destination({
    required this.name,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });
}

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu, color: Colors.white),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}
