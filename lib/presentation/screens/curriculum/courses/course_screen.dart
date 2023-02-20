import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:esjourney/logic/cubits/curriculum/course_cubit.dart';
import 'package:esjourney/logic/cubits/curriculum/course_state.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/curriculum/course_widget.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tab_container/tab_container.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final TabContainerController _controller;

  @override
  void initState() {
    _controller = TabContainerController(length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = ScreenSize.height(context);
    final double width = ScreenSize.width(context);
    final getCourses = BlocProvider.of<CourseCubit>(context);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLogInSuccess) {
          final user = state.user;
          getCourses.getAllCourses(user.token);
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 8, right: 20, left: 20),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Hi",
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          user.username,
                          style: const TextStyle(
                            overflow: TextOverflow.fade,
                            letterSpacing: 1.5,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    CachedNetworkImage(
                        imageUrl: user.twoDAvatar!,
                        placeholderFadeInDuration: const Duration(seconds: 2),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(width * 0.1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: width * 0.1,
                              backgroundColor: Colors.transparent,
                              backgroundImage: imageProvider,
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(top: 16, right: 20, left: 20),
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 10),
                        child: Row(
                          children: <Widget>[
                            const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                "assets/images/curriculum/badge.png",
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "View progress",
                                      softWrap: false,
                                      style: TextStyle(
                                        overflow: TextOverflow.fade,
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      user.grade.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 16, bottom: 16, left: 10),
                        child: Row(
                          children: <Widget>[
                            const CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(
                                "assets/images/curriculum/coin.png",
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Balance",
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      user.coins.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16, right: 20, left: 20),
                  child: TabContainer(
                    color: Colors.white,
                    controller: _controller,
                    radius: 20,
                    tabEdge: TabEdge.top,
                    tabCurve: Curves.easeIn,
                    tabs: _getTabs1(),
                    children: _getChildren1(height, width),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<String> _getTabs1() {
    return <String>[
      "Courses",
      "Games",
    ];
  }

  List<Widget> _getChildren1(double height, double width) {
    List<Game> allGames = [
      Game(
        title: "Hangman",
        imagePath: "assets/images/curriculum/hangman.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.hangmanGame);
        },
      ),
      Game(
        title: "Wordly",
        imagePath: "assets/images/curriculum/wordle.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.wordlyGame);
        },
      ),
      Game(
        title: "Memory",
        imagePath: "assets/images/curriculum/memory.png",
        onTap: () {
          //Navigator.of(context).pushNamed(AppRoutes.memoryGame);
        },
      ),
      Game(
        title: "Slide",
        imagePath: "assets/images/curriculum/slide.png",
        onTap: () {
          //Navigator.of(context).pushNamed(AppRoutes.slideGame);
        },
      ),
      Game(
        title: "Jackpot",
        imagePath: "assets/images/curriculum/jackpot.png",
        onTap: () {
          //Navigator.of(context).pushNamed(AppRoutes.jackpotGame);
        },
      ),
      Game(
        title: "LogicBot",
        imagePath: "assets/images/curriculum/logicbot.png",
        onTap: () {
          print("unity game in progress");
        },
      ),
      Game(
        title: "Draw",
        imagePath: "assets/images/curriculum/draw.png",
        onTap: () {
          print("server/draw game in progress");
        },
      ),
    ];

    return <Widget>[
      BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          if (state is CourseLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseSuccess) {
            final courses = state.courses;
            return CustomScrollView(
              slivers: <Widget>[
                SliverDynamicHeightGridView(
                  itemCount: courses.length,
                  crossAxisCount: 2,
                  builder: (ctx, index) {
                    final course = courses[index];
                    return CourseItem(
                      height: height,
                      width: width,
                      imagePath: "assets/images/curriculum/hangman.png",
                      courseTitle: course.title,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.courseDetails,
                          arguments: course,
                        );
                      },
                    );
                  },
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      CustomScrollView(
        slivers: <Widget>[
          SliverDynamicHeightGridView(
            itemCount: allGames.length,
            crossAxisCount: 2,
            builder: (ctx, index) {
              final game = allGames[index];
              return CourseItem(
                height: height,
                width: width,
                imagePath: game.imagePath,
                courseTitle: game.title,
                onTap: game.onTap,
              );
            },
          ),
        ],
      ),
    ];
  }
}

class Game {
  final String title;
  final String imagePath;
  final void Function() onTap;

  Game({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
}
