import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:esjourney/presentation/screens/Events/event_list_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/courses/course_screen.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/club/clubs_screen.dart';
import 'package:esjourney/presentation/widgets/drawer_icon.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'Internship/InternshipHomePage.dart';
import 'home/home_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const DrawerIcon(),
        actions: [
          IconButton(
            icon:  const Icon(FontAwesomeIcons.message),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.messages);
            },
          ),
          const SizedBox(width: AppSizes.ksmallSpace),
          const Icon(FontAwesomeIcons.bell),
          const SizedBox(width: AppSizes.ksmallSpace)
        ],
      ),
      body: CurvedNavBar(
        actionButton: CurvedActionBar(
            onTab: (value) {},
            activeIcon: Container(
              padding: const EdgeInsets.all(AppSizes.kbigSpace - 6),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary, shape: BoxShape.circle),
              child: Icon(
                Icons.emoji_events,
                size: AppSizes.kiconSize + 8,
                color: theme.colorScheme.surface,
              ),
            ),
            inActiveIcon: Container(
              padding: const EdgeInsets.all(AppSizes.kbigSpace - 6),
              decoration: BoxDecoration(
                  color: theme.colorScheme.primary, shape: BoxShape.circle),
              child: Icon(
                Icons.emoji_events,
                size: AppSizes.kiconSize + 8,
                color: theme.colorScheme.surface,
              ),
            ),
            text: ''),
        navBarBackgroundColor: theme.colorScheme.surface,
        //activeColor: Colors.yellow,
        //inActiveColor: theme.colorScheme.onBackground,
        appBarItems: [
          FABBottomAppBarItem(
              activeIcon: Icon(
                FontAwesomeIcons.house,
                color: theme.colorScheme.primary,
              ),
              inActiveIcon: const Icon(
                FontAwesomeIcons.house,
              ),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: Icon(
                FontAwesomeIcons.briefcase,
                color: theme.colorScheme.primary,
              ),
              inActiveIcon: const Icon(
                FontAwesomeIcons.briefcase,
              ),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: Icon(
                FontAwesomeIcons.graduationCap,
                color: theme.colorScheme.primary,
              ),
              inActiveIcon: const Icon(
                FontAwesomeIcons.graduationCap,
              ),
              text: ''),
          FABBottomAppBarItem(
              activeIcon: Icon(
                FontAwesomeIcons.peopleGroup,
                color: theme.colorScheme.primary,
              ),
              inActiveIcon: const Icon(
                FontAwesomeIcons.peopleGroup,
              ),
              text: ''),
        ],
        bodyItems: [

          HomeScreen(),
          InternshipHomePage(),
          const EventListScreen(),
          const ClubsScreen()
        ],
        actionBarView: const CourseScreen(),
        extendBody: false,
      ),
    );
  }
}
