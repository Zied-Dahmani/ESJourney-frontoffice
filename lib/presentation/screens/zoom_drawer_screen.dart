import 'dart:io';

import 'package:esjourney/presentation/screens/club_event/my_events_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/screens/application/applications_screen.dart';
import 'package:esjourney/presentation/screens/club_event/club_events_map_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/bloc/user_cubit/drawer_cubit.dart';
import 'package:esjourney/presentation/screens/drawer_screen.dart';
import 'package:esjourney/presentation/screens/main_screen.dart';
import 'package:esjourney/presentation/screens/profile/profile_screen.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'Directions/Locations.dart';
import 'Directions/detect.dart';
import 'Events/calendar_screen.dart';
import 'package:provider/provider.dart';

import 'Internship/chat_bot_screen.dart';
import 'curriculum/faq/faq_screen.dart';

class ZoomDrawerScreen extends StatefulWidget {
  const ZoomDrawerScreen({Key? key}) : super(key: key);

  @override
  State<ZoomDrawerScreen> createState() => _ZoomDrawerScreenState();
}

class _ZoomDrawerScreenState extends State<ZoomDrawerScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(AppStrings.knotification,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color:
                        Theme.of(context).colorScheme.outline)),
                content: Text(message.notification!.body.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppStrings.kok,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.outline))),
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //start set user as connected
    final socketService = Provider.of<SocketService>(context, listen: false);
    final userState = context.read<UserCubit>().state;
    if (userState is UserLogInSuccess) {
      socketService.connect(userState.user.token!);
      Provider.of<DrawerCubit>(context, listen: false).setUsername(userState.user.username);
    }
    //end set user as connected
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLogInSuccess) {
            if(Platform.isAndroid) {

              BlocProvider.of<UserCubit>(context).updateDeviceToken(state.user.token);
            }

            return ZoomDrawer(
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
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return const MainScreen();
      case 1:
        return  CalendarScreen();
      case 2:
        return const ClubEventsMapScreen();
      case 3:
        return const ApplicationsScreen();
      case 4:
        return MyEventsScreen();
      case 5:
        return ProfileScreen();
      case 6:
        return ChatBotScreen();
      case 7:
        return FAQScreen();
        case 8:
        return DestinationScreen();
      default:
        return const ProfileScreen();
    }
  }
}
