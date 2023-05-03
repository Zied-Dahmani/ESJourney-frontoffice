import 'package:esjourney/data/models/challenges/leaderboard/leaderboard_res.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_cubit.dart';
import 'package:esjourney/logic/cubits/challenges/leaderboard_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/challenges/top-three_users_homepage.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/challenges/posts/post_cubit.dart';
import '../../../logic/cubits/challenges/posts/post_state.dart';

String image = "https://picsum.photos/400/600";
List<LeaderboardRes> allTimeTop3 = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        body: BlocBuilder<LeaderboardCubit, LeaderboardState>(
            builder: (context, state) {
          if (state is LeaderboardLoadInProgress) {
          } else if (state is LeaderboardSuccess) {
            return NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  CupertinoSliverRefreshControl(onRefresh: () async {
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
                              firstUsername: state.allTimeUsers[0].username,
                              secondUsername: state.allTimeUsers[1].username,
                              thirdUsername: state.allTimeUsers[2].username,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Wrap the TabBar widget with a SliverPersistentHeader widget
                ];
              },
              body: const PostsList(),
            );
          } else if (state is LeaderboardIsFailure) {
            return const Center(child: CircularProgressIndicator());
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
  const PostsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Expanded(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return const PostListItem();
          },
        ),
      );
}

class PostListItem extends StatelessWidget {
  const PostListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = ScreenSize.width(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  image,
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
                  const Text(
                    "SouhailKrs",
                    style: TextStyle(
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
              image,
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
  }
}
