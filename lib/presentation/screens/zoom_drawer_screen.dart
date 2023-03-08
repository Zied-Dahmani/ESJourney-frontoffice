import 'package:esjourney/presentation/screens/application/applications_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_events_map_screen.dart';
import 'package:esjourney/presentation/screens/drawer_screen.dart';
import 'package:esjourney/presentation/screens/main_screen.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomDrawerScreen extends StatefulWidget {
  const ZoomDrawerScreen({Key? key}) : super(key: key);

  @override
  State<ZoomDrawerScreen> createState() => _ZoomDrawerScreenState();
}

class _ZoomDrawerScreenState extends State<ZoomDrawerScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: ZoomDrawer(
        menuScreen: DrawerScreen(
          setIndex: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        mainScreen: currentScreen(),
        borderRadius: AppSizes.kradius,
        showShadow: true,
        angle: 0.0,
        slideWidth: 220,
        menuBackgroundColor: theme.colorScheme.primary,
      ),
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return const MainScreen();
      case 1:
        return Container(color: Colors.yellow);
      case 2:
        return const ClubEventsMapScreen();
      case 3:
        return const ApplicationsScreen();
      case 4:
        return const MainScreen();
      default:
        return const MainScreen();
    }
  }
}
