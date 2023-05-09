import 'dart:io';
import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/utils/dynamic_link.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class LikeAndShareContainer extends StatelessWidget {
  LikeAndShareContainer({Key? key, this.club}) : super(key: key);

  var club;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.kbigSpace, vertical: AppSizes.kbigSpace),
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.kradius))),
      child: Row(
        children: [
          // TODO Likes
          LikeButton(
            circleColor: CircleColor(
                start: theme.colorScheme.outline,
                end: theme.colorScheme.outline),
            bubblesColor: BubblesColor(
              dotPrimaryColor: theme.colorScheme.primary,
              dotSecondaryColor: theme.colorScheme.primary,
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                //BlocProvider.of<ClubCubit>(context).isLiked(isLiked,club)
                isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: theme.colorScheme.primary,
                size: AppSizes.kiconSize,
              );
            },
            likeCount: club.likes.length,
            countBuilder: (int? count, bool isLiked, String text) {
              return Text(
                text,
                style: theme.textTheme.bodyMedium,
              );
            },
          ),
          const Spacer(),
          IconButton(
              onPressed: () async {
                DynamicLink().create(club.id).then((value) {
                  BlocProvider.of<ClubCubit>(context).shareClub(club, value);
                });
              },
              icon: Icon(Platform.isAndroid ? Icons.share : Icons.ios_share,
                  color: theme.colorScheme.primary))
        ],
      ),
    );
  }
}
