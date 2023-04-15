import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/screens/application/applications_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_events_map_screen.dart';
import 'package:esjourney/presentation/screens/drawer_screen.dart';
import 'package:esjourney/presentation/screens/main_screen.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'Events/calendar_screen.dart';
import 'package:provider/provider.dart';

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
    //start set user as connected
    final socketService = Provider.of<SocketService>(context, listen: false);
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      socketService.connect(userState.user.token!);
    }
    //end set user as connected
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
        return const CalendarScreen();
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
