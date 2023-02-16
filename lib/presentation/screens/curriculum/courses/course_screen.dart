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

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = ScreenSize.height(context);
    final double width = ScreenSize.width(context);
    final getCourses = BlocProvider.of<CourseCubit>(context);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLogInSuccess) {
          final user = state.user;
          getCourses.getAllCourses(user.token!);
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //TODO : DONE
              Container(
                margin: EdgeInsets.only(
                  right: 0.08 * width,
                  left: 0.08 * width,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Hi, ${user.username}",
                          style: TextStyle(
                            fontSize: 0.08 * width,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "Let's make this day productive",
                          style: TextStyle(
                            fontSize: 0.035 * width,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Material(
                      borderRadius: BorderRadius.circular(0.1 * width),
                      elevation: 10,
                      child: CircleAvatar(
                        radius: 0.1 * width,
                        backgroundImage: const AssetImage(
                            "assets/images/curriculum/profile_pic.jpg"),
                      ),
                    ),
                  ],
                ),
              ),
              //TODO : DONE
              Container(
                margin: EdgeInsets.only(
                  top: 0.05 * height,
                  right: 0.08 * width,
                  left: 0.08 * width,
                ),
                padding: EdgeInsets.only(
                  top: 0.02 * height,
                  bottom: 0.02 * height,
                  right: 0.02 * width,
                  left: 0.02 * width,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.levelMap,
                            arguments: user.grade,
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "assets/images/curriculum/badge.png",
                              scale: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 0.02 * width,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "View progress",
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "Level ${user.grade}",
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 0.01 * height,
                        bottom: 0.01 * height,
                      ),
                      child: const VerticalDivider(
                        color: Colors.grey,
                        thickness: 0.6,
                      ),
                    ),
                    Flexible(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/curriculum/coin.png",
                            scale: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 0.02 * width,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "Points",
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "1200",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //TODO : DONE
              Container(
                margin: EdgeInsets.only(
                  top: 0.03 * height,
                  right: 0.08 * width,
                  left: 0.08 * width,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "COURSES",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 0.04 * width,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              //TODO : DONE
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 0.03 * height,
                    right: 0.08 * width,
                    left: 0.08 * width,
                    bottom: 0.03 * height,
                  ),
                  child: BlocBuilder<CourseCubit, CourseState>(
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
                                  imagePath:
                                      "assets/images/curriculum/hangman.png",
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
                ),
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
