import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:esjourney/presentation/screens/Events/event_list_screen.dart';
import 'package:esjourney/presentation/screens/club/clubs_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/courses/course_screen.dart';
import 'package:esjourney/presentation/screens/home/home_screen.dart';
import 'package:esjourney/presentation/screens/Internship/InternshipHomePage.dart';

import '../../utils/theme.dart';
import '../router/routes.dart';
import '../widgets/drawer_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController();
  var _currentIndex = 0;

  // List of titles for each tab
  final List<String> _titles = ['Home', 'Internship', 'Events', 'Clubs', 'Courses'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),  // Set title according to current index
        leading: const DrawerIcon(),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.message),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.messages);
            },
          ),
          const SizedBox(width: AppSizes.ksmallSpace),
          const Icon(Icons.notifications_none),
          const SizedBox(width: AppSizes.ksmallSpace)
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: const <Widget>[
          HomeScreen(),
          InternshipHomePage(),
          EventListScreen(),
          ClubsScreen(),
          CourseScreen(),
        ],
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _pageController.jumpToPage(4);
        },
        child: Icon(
          _currentIndex == 4
              ? Icons.emoji_events
              : Icons.emoji_events,
          color: _currentIndex == 4
              ? Colors.white
              : Colors.grey.shade400,
           // Adjust this value as needed
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: 4,
        tabBuilder: (int index, bool isActive) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                index == 0
                    ? FontAwesomeIcons.house
                    : index == 1
                    ? FontAwesomeIcons.briefcase
                    : index == 2
                    ? FontAwesomeIcons.graduationCap
                    : FontAwesomeIcons.peopleGroup,
                size: 24,
                color: isActive ? Colors.redAccent.shade400 : Colors.grey,
              ),
              const SizedBox(height: 4),
            ],
          );
        },
        backgroundColor: Theme.of(context).canvasColor,
        activeIndex: _currentIndex,
        splashColor: Theme.of(context).primaryColor,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
