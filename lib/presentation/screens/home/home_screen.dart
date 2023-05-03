import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/challenges/top-three_users_homepage.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/challenges/post/post_model/post_model.dart';
import '../../../logic/cubits/challenges/posts/post_cubit.dart';
import '../../../logic/cubits/challenges/posts/post_state.dart';
import '../../../utils/constants.dart';

List<LeaderboardRes> allTimeTop3 = [];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Post> posts = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<PostCubit>(context).getPosts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: Builder(builder: (context) {
          final leaderboardState = context.watch<LeaderboardCubit>().state;
          final postState = context.watch<PostCubit>().state;
          if (leaderboardState is LeaderboardLoadInProgress &&
              postState is PostLoadInProgress) {
          } else if (leaderboardState is LeaderboardSuccess &&
              postState is PostIsSuccess) {
            for (int i = 0; i < postState.posts.length; i++) {
              posts.add(postState.posts[i]);
            }

            return NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  CupertinoSliverRefreshControl(onRefresh: () async {
                    print("hereere");
                    await Future.delayed(const Duration(seconds: 2));

                  }),
                  const SliverAppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: false,
                    pinned: false,
                  ),
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
                              firstUsername:
                                  leaderboardState.allTimeUsers[0].username,
                              secondUsername:
                                  leaderboardState.allTimeUsers[1].username,
                              thirdUsername:
                                  leaderboardState.allTimeUsers[2].username,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Wrap the TabBar widget with a SliverPersistentHeader widget
                ];
              },
              body: PostsList(posts: posts),
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
            BlocProvider.of<PostCubit>(context).emit(PostInitial());
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
    required this.posts, // Add the required posts parameter
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double width = ScreenSize.width(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
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
                            Text("2h",
                                style: TextStyle(
                                  fontFamily: 'VisbyRoundCF',
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width * 0.02,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "${kbaseUrl}img/${posts[index].posts[0].mediaContent!}",
                        fit: BoxFit.cover,
                        height: 350,
                        width: double.infinity,
                      ),
                    ),
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
