import 'dart:convert';
import 'dart:io' show Directory, File, Platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:esjourney/logic/cubits/curriculum/course_cubit.dart';
import 'package:esjourney/logic/cubits/curriculum/course_state.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tab_container/tab_container.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);


  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final TabContainerController _controller;
  BuildContext? dialogContext;

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
    final double width = ScreenSize.width(context);
    precacheImage(
        const AssetImage(
            "assets/images/curriculum/map/map_vertical_infinity.png"),
        context);

    List<Game> allGames = [
      Game(
        colors: [
          const Color(0xff0F2027),
          const Color(0xff203A43),
          const Color(0xff2C5364),
        ],
        title: "Hangman",
        imagePath: "assets/images/curriculum/hangman.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.hangmanGame);
        },
      ),
      Game(
        colors: [
          const Color(0xffb92b27),
          const Color(0xff1565C0),
        ],
        title: "Wordly",
        imagePath: "assets/images/curriculum/wordle.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.wordlyGame);
        },
      ),
      /*Game(
        colors: [
          const Color(0xff373B44),
          const Color(0xff4286f4),
        ],
        title: "Memory",
        imagePath: "assets/images/curriculum/memory.png",
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.memoryGame);
        },
      ),
      Game(
        colors: [
          const Color(0xff12c2e9),
          const Color(0xffc471ed),
          const Color(0xfff64f59),
        ],
        title: "Slide",
        imagePath: "assets/images/curriculum/slide.png",
        onTap: () {
          double swidth = MediaQuery.of(context).size.width * 0.8;
          if (width >= 425) {
            swidth = MediaQuery.of(context).size.width * 0.4;
          }
          if (width >= 1000) {
            swidth = MediaQuery.of(context).size.width * 0.28;
          }

          Provider.of<BoardController>(context, listen: false)
              .init(width: swidth);
          Navigator.of(context).pushNamed(AppRoutes.slideGame);
        },
      ),
      Game(
        colors: [
          const Color(0xff8360c3),
          const Color(0xff2ebf91),
        ],
        title: "Jackpot",
        imagePath: "assets/images/curriculum/jackpot.png",
        onTap: () async {
          bool canNavigate = await canNavigateToScreen();
          if (canNavigate) {
            Navigator.of(context).pushNamed(AppRoutes.jackpotGame);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "You can only play this game once a day",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
      ),*/
      Game(
        colors: [
          const Color(0xff74ebd5),
          const Color(0xffACB6E5),
        ],
        title: "LogicBot",
        imagePath: "assets/images/curriculum/logicbot.png",
        onTap: () {

        },
      ),
      Game(
        colors: [
          const Color(0xffBE93C5),
          const Color(0xff7BC6CC),
        ],
        title: "Draw",
        imagePath: "assets/images/curriculum/draw.png",
        onTap: () {
          //Navigator.of(context).pushNamed(AppRoutes.homeDraw);
          Navigator.pushNamed(context, AppRoutes.listDrawRoom);
        },
      ),
    ];
    final userState = Provider.of<UserCubit>(context).state;
    var user;
    if (userState is UserLogInSuccess) {
      user = userState.user;
    }

    return BlocListener<CourseCubit, CourseState>(
      listener: (context, state) {
        if (state is CourseLoadInProgress) {

        } else if (state is CourseSuccess) {
          Navigator.of(context).pushNamed(AppRoutes.mapLevels,arguments: state.courses);
        } else if (state is CourseIsFailure) {
          Navigator.pop(dialogContext!);
          print(state.error);
        }
      },
      child: Column(
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
                          color: Colors.white60,
                          borderRadius:
                          BorderRadius.circular(width * 0.1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: const Offset(6, 6),
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                  user.coins.toStringAsFixed(2),
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
          Container(
            margin: const EdgeInsets.only(top: 16, right: 20, left: 20),
            child: Row(
              children: const <Widget>[
                Text(
                  "Games",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          CarouselSlider(
            items: [
              for (final game in allGames)
                GameCardWidget(
                  game: game,
                ),
            ],
            options: CarouselOptions(
              animateToClosest: true,
              autoPlay: false,
              disableCenter: true,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              scrollPhysics: const BouncingScrollPhysics(),
              initialPage: 0,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              padEnds: false,
              pageSnapping: true,
              scrollDirection: Axis.horizontal,
              viewportFraction: 0.8,
            ),
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              top: 16,
              right: 20,
              left: 20,
              bottom: 16,
            ),
            padding: const EdgeInsets.only(
              top: 16,
              right: 20,
              left: 20,
              bottom: 16,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEB4A5A),
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              onPressed: () {
                print(user.token);
                BlocProvider.of<CourseCubit>(context).getAllCourses(
                    user.token!);

              },
              child: const Text(
                "Start Journey",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }

  Future<bool> canNavigateToScreen() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/last_visit.json';

    if (File(path).existsSync()) {
      String fileContents = File(path).readAsStringSync();
      Map<String, dynamic> data = jsonDecode(fileContents);
      DateTime lastVisitDate = DateTime.parse(data['last_visit_date']);

      DateTime now = DateTime.now();
      if (lastVisitDate.year == now.year &&
          lastVisitDate.month == now.month &&
          lastVisitDate.day == now.day) {
        return false;
      }
    }

    Map<String, dynamic> data = {'last_visit_date': DateTime.now().toString()};
    File(path).writeAsStringSync(jsonEncode(data));
    return true;
  }
}

class GameCardWidget extends StatelessWidget {
  const GameCardWidget({
    super.key,
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16, right: 8, left: 8),
      decoration: BoxDecoration(
        //gradient background
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: game.colors,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          children: [
            Flexible(
              child: Image.asset(game.imagePath),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      game.title,
                      style: const TextStyle(
                          color: Colors.white, letterSpacing: 3),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, right: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: game.onTap,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text("Play"),
                            Icon(Icons.play_arrow),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Game {
  final String title;
  final String imagePath;
  final List<Color> colors;
  final void Function() onTap;

  Game({
    required this.colors,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });
}
