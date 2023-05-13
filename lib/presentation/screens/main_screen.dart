import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:esjourney/presentation/screens/Events/event_list_screen.dart';
import 'package:esjourney/presentation/screens/club/clubs_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/courses/course_screen.dart';
import 'package:esjourney/presentation/screens/home/home_screen.dart';
import 'package:esjourney/presentation/screens/Internship/InternshipHomePage.dart';
import '../router/routes.dart';
import '../widgets/drawer_icon.dart';
import 'package:esjourney/data/models/events/event_model.dart';

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
    const IconData messenger_outline_outlined = IconData(0xef42, fontFamily: 'MaterialIcons');
    final theme = Theme.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72), // Adjust the height as needed
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1), // Set the shadow color
                spreadRadius: 2, // Set the spread radius
                blurRadius: 5, // Set the blur radius
                offset: const Offset(0, 3), // Set the offset
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20), // Adjust the corner radius as needed
              bottomRight: Radius.circular(20), // Adjust the corner radius as needed
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                _titles[_currentIndex],
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              leading: const DrawerIcon(),
              actions: [

                IconButton(
                  icon: const Icon(
                    messenger_outline_outlined, // Apply a custom icon
                    size: 24, // Adjust the icon size as needed
                    color: Colors.black, // Set a custom icon color
                  ),
                  onPressed: () {
                    // Handle the envelope icon button press
                    Navigator.of(context).pushNamed(AppRoutes.messages);
                  },
                ),
                const SizedBox(width: 8), // Adjust the spacing as needed
                const Icon(
                  FontAwesomeIcons.bell, // Apply a custom icon
                  size: 24, // Adjust the icon size as needed
                  color: Colors.black, // Set a custom icon color
                ),
                const SizedBox(width: 8), // Adjust the spacing as needed
              ],
            ),
          ),
        ),
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
              : Colors.white,
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
