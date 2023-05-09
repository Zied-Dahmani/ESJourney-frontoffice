import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'detect.dart';

class DestinationScreen extends StatefulWidget {
  const DestinationScreen({Key? key}) : super(key: key);

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final _destinations = [
    Destination(name: 'Bloc G', imageUrl: 'assets/images/Logo_ESPRIT_Ariana.jpg', latitude: 36.89877138293219, longitude: 10.189069059858745),
    Destination(name: 'Bloc E', imageUrl:  'assets/images/Logo_ESPRIT_Ariana.jpg', latitude: 36.8996143056227, longitude: 10.189819348195497),
    Destination(name: 'Bloc H', imageUrl: 'assets/images/logo-esb.png', latitude: 36.8979926492164, longitude: 10.189644899020355),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose destination'),
      ),
      body: ListView.builder(
        itemCount: _destinations.length,
        itemBuilder: (context, index) {
          final destination = _destinations[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    destination.imageUrl,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    destination.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  icon: Icon(Icons.directions, color: Colors.blue),
                  label: Text(
                    'Directions',
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
                SizedBox(height: 8),
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
