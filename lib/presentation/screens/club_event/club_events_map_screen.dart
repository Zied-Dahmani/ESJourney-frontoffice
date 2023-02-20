import 'dart:ui';

import 'package:esjourney/presentation/widgets/drawer_icon.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

// TODO Make data, logic, and presentation

final _myLocation = LatLng(36.892484, 10.186765);
const token = 'pk.eyJ1IjoiemllZC1kYWhtYW5pIiwiYSI6ImNsZWJnd3RjMjA1c3kzb210OWQ0YW1pb2kifQ.KNa3PMeruCB7HdCN9zDfQQ';
const map_style = 'mapbox.mapbox-streets-v8';

class ClubEventsMapScreen extends StatefulWidget {
  ClubEventsMapScreen({Key? key}) : super(key: key);

  @override
  State<ClubEventsMapScreen> createState() => _ClubEventsMapScreenState();
}

class _ClubEventsMapScreenState extends State<ClubEventsMapScreen>
    with SingleTickerProviderStateMixin {
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = 0;

  List<Marker> _buildMarkers() {
    final events = <Marker>[];
    events.add(Marker(
        height: AppSizes.kmarkerSizeExpanded,
        width: AppSizes.kmarkerSizeExpanded,
        point: LatLng(36.892484, 10.196765),
        builder: (_) {
          return GestureDetector(
            onTap: () {
              _selectedIndex = 0;
              setState(() {
                _pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              });
            },
            child: EventMarker(isSelected: _selectedIndex == 0),
          );
        }));
    events.add(Marker(
        height: AppSizes.kmarkerSizeExpanded,
        width: AppSizes.kmarkerSizeExpanded,
        point: LatLng(36.892484, 10.229988),
        builder: (_) {
          return GestureDetector(
            onTap: () {
              _selectedIndex = 1;
              setState(() {
                _pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              });
            },
            child: EventMarker(isSelected: _selectedIndex == 1),
          );
        }));
    return events;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final events = _buildMarkers();
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(maxZoom: 16, zoom: 13, center: _myLocation),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate: 'https://api.mapbox.com/styles/v1/zied-dahmani/cled45t8y001801muszxjo9ti/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                additionalOptions: const {
                  'accessToken': token,
                  'id': map_style
                },
              ),
              MarkerLayer(markers: events),
              MarkerLayer(
                markers: [
                  Marker(
                      height: 60,
                      width: 60,
                      point: _myLocation,
                      builder: (_) {
                        return MyLocationMarker(
                            animation: _animationController);
                      })
                ],
              ),
              const Positioned(left: 10, top: 30, child: DrawerIcon()),
              Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                height: ScreenSize.height(context) * .3,
                child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      return EventDetailsCard(marker: events[index]);
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyLocationMarker extends AnimatedWidget {
  const MyLocationMarker({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(.5, 1.0, value)!;
    return Stack(
      children: [
        Center(
          child: Container(
            height: 50 * newValue,
            width: 50 * newValue,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                shape: BoxShape.circle),
          ),
        ),
        Center(
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}

class EventMarker extends StatelessWidget {
  const EventMarker({Key? key, this.isSelected = false}) : super(key: key);

  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final size = isSelected
        ? AppSizes.kmarkerSizeExpanded
        : AppSizes.kmarkerSizeShrinked;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: SvgPicture.asset('assets/images/marker.svg'),
      ),
    );
  }
}

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({Key? key, required Marker marker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizes.kbigSpace),
      child: Card(
        color: theme.colorScheme.background,
        child: Text(
          'dasdad',
          style: theme.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
