import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/screens/application/applications_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_events_map_screen.dart';
import 'package:esjourney/presentation/screens/drawer_screen.dart';
import 'package:esjourney/presentation/screens/main_screen.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'Events/calendar_screen.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class ZoomDrawerScreen extends StatefulWidget {
  const ZoomDrawerScreen({Key? key}) : super(key: key);

  @override
  State<ZoomDrawerScreen> createState() => _ZoomDrawerScreenState();
}

class _ZoomDrawerScreenState extends State<ZoomDrawerScreen> {
  int currentIndex = 0;
  bool _isFirstTime = true;
  bool isDialogShowing = false;

  listenFCM(context) {
    final theme = Theme.of(context);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (!isDialogShowing) {
        isDialogShowing = true;
        showDialog(
          context: context,
          builder: (BuildContext _) => AlertDialog(
            backgroundColor: theme.colorScheme.background,
            title: Text(message.notification!.title!,
                style: theme.textTheme.headlineMedium),
            content: Text(message.notification!.body!,
                style: theme.textTheme.bodyMedium),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  isDialogShowing = false;
                },
                child: Text(AppStrings.kok,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: theme.colorScheme.primary)),
              ),
            ],
          ),
        ).then((result) {
          if (result == null) {
            isDialogShowing = false;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    listenFCM(context);
    final theme = Theme.of(context);
    //start set user as connected
    final socketService = Provider.of<SocketService>(context, listen: false);
    //end set user as connected

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLogInSuccess) {
          if (_isFirstTime) {
            _isFirstTime = false;
            BlocProvider.of<UserCubit>(context).updateDeviceToken(state.user.token!);
          }
          socketService.connect(state.user.token!);
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
        return const SizedBox();
      },
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
