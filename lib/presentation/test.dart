import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/screen_size.dart';

String image = "https://picsum.photos/400/600";

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    String photoUrl = "https://picsum.photos/400/600";

    return Scaffold(
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CupertinoSliverRefreshControl(onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
            }),
            const SliverAppBar(
              backgroundColor: Colors.transparent,
              title: Text("Viator"),
              centerTitle: false,
              pinned: false,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(" t.moments"),
                    ],
                  ),
                ],
              ),
            ),
            // Wrap the TabBar widget with a SliverPersistentHeader widget
          ];
        },
        body: MomentsList(),
      ),
    );
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text(
          " t.moments",
          style: theme.textTheme.headlineLarge,
        ),
        const SizedBox(height: 30),
        const MomentsList(),
      ],
    );
  }
}

class MomentsList extends StatelessWidget {
  const MomentsList({
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
