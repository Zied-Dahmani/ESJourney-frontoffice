import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_state.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/challenges/posts/post_model.dart';
import '../../../data/models/user_model.dart';
import '../../../logic/cubits/challenges/posts/posts_cubit.dart';
import '../../../logic/cubits/challenges/posts/posts_state.dart';
import '../../../logic/cubits/user/user_cubit.dart';
import '../../../utils/constants.dart';
import '../../widgets/challenges/top_three_users_homepage.dart';

late User user;
List<LeaderboardRes> allTimeTop3 = [];



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

ValueNotifier<bool> isLiked = ValueNotifier<bool>(false);

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts();

    super.initState();
  }

  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Builder(builder: (context) {
          final leaderboardState = context.watch<LeaderboardCubit>().state;
          final postState = context.watch<PostCubit>().state;
          final userState = context.watch<UserCubit>().state;
          if (leaderboardState is LeaderboardLoadInProgress &&
              postState is PostLoadInProgress) {
          } else if (leaderboardState is LeaderboardSuccess &&
              postState is PostIsSuccess &&
              userState is UserLogInSuccess) {
            for (int i = 0; i < leaderboardState.allTimeUsers.length; i++) {
              allTimeTop3.add(leaderboardState.allTimeUsers[i]);
            }
            user = userState.user;
            print("user is " + user.toString());
            return NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  CupertinoSliverRefreshControl(onRefresh: () async {

                    await Future.delayed(const Duration(seconds: 2));
                  }),

                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'TOP 3',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'VisbyRoundCF',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: width * 0.03,
                            ),
                            TopThreeUsersHomePage(
                              allTimeTopThree: allTimeTop3,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Wrap the TabBar widget with a SliverPersistentHeader widget
                ];
              },
              body: PostsList(
                posts: postState.posts.cast<Post>(),
              ),
            );
          } else if (leaderboardState is LeaderboardIsFailure &&
              postState is PostIsFailure) {
            return const Center(child: Text("Something went wrong"));
          }
          return const Center(child: CircularProgressIndicator());
        }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.colorScheme.primary,
          onPressed: () {
            //BlocProvider.of<PostCubit>(context).emit(PostInitial());

            Navigator.pushNamed(context, AppRoutes.createPostScreen);
          },
          shape: const CircleBorder(),
          child: const Icon(
            Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ));
  }
}

class PostsList extends StatelessWidget {
  final List<Post> posts;

  const PostsList({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> expanded = ValueNotifier<bool>(false);
    ValueNotifier<bool> isLiked = ValueNotifier<bool>(false);
    void _toggleExpand() {
      expanded.value = !expanded.value;
    }

    final double width = ScreenSize.width(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {

              isLiked.value = posts[index].likedBy.contains(user.id);
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            posts[index].avatar,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        SizedBox(width: width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              posts[index].username,
                              style: const TextStyle(
                                fontFamily: 'VisbyRoundCF',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              getTimeAgo(posts[index].createdAt) ?? ' ',

                              style: TextStyle(
                                fontFamily: 'VisbyRoundCF',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[400],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),
                    if (posts[index].mediaContent != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          "${kbaseUrl}img/${posts[index].mediaContent!}",
                          fit: BoxFit.cover,
                          height: 350,
                          width: double.infinity,
                        ),
                      ),
                    if (posts[index].mediaContent != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ValueListenableBuilder<bool>(
                            valueListenable: isLiked,
                            builder: (BuildContext context, bool isLikedValue,
                                Widget? child) {
                              return IconButton(
                                onPressed: () {
                                  BlocProvider.of<PostCubit>(context)
                                      .likePost(posts[index].id);
                                  isLiked.value = !isLikedValue;

                                },
                                icon: isLikedValue
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.favorite_border,
                                        color: Colors.black,
                                      ),
                              );
                            },
                          ),
                          Text("112"),
                        ],
                      ),
                    ValueListenableBuilder<bool>(
                        valueListenable: expanded,
                        builder: (BuildContext context, bool expanded,
                            Widget? child) {
                          return GestureDetector(
                            onTap: _toggleExpand,
                            child: Text(
                              posts[index].status,
                              maxLines: expanded ? null : 1,
                            ),
                          );
                        }),
                    ValueListenableBuilder<bool>(
                        valueListenable: expanded,
                        builder: (BuildContext context, bool expanded,
                            Widget? child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: !expanded,
                                child: GestureDetector(
                                  onTap: _toggleExpand,
                                  child: Visibility(
                                    visible: posts[index].status.length > 62,
                                    child: const Text(
                                      "more...",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: width * 0.03,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String? getTimeAgo(int time) {
  const int secondMillis = 1000;
  const int minuteMillis = 60 * secondMillis;
  const int hourMillis = 60 * minuteMillis;
  const int dayMillis = 24 * hourMillis;
  const int weekMillis = 7 * dayMillis;
  int timeAgo = time;

  if (timeAgo < 1000000000) {
    timeAgo *= 1000;
  }

  final int now = DateTime.now().millisecondsSinceEpoch;
  if (timeAgo > now || timeAgo <= 0) {
    return null;
  }

  final int diff = now - timeAgo;
  if (diff < minuteMillis) {
    return 'just now';
  } else if (diff < 2 * minuteMillis) {
    return '1m ago';
  } else if (diff < 50 * minuteMillis) {
    return '${(diff / minuteMillis).floor()}m ago';
  } else if (diff < 90 * minuteMillis) {
    return '1h ago';
  } else if (diff < 24 * hourMillis) {
    final int hours = (diff / hourMillis).floor();
    return hours == 1 ? '1h ago' : '${hours}h ago';
  } else if (diff < 48 * hourMillis) {
    return '1d ago';
  } else {
    final int weeks = (diff / weekMillis).floor();
    return weeks == 1 ? '1w ago' : '${weeks}w ago';
  }
}

