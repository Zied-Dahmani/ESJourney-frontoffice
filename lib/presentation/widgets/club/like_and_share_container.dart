import 'dart:io';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class LikeAndShareContainer extends StatelessWidget {
  const LikeAndShareContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.kbigSpace,
          vertical: AppSizes.ksmallSpace),
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.kradius))),
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           /* LikeButton(
              circleColor: CircleColor(start: theme.colorScheme.outline, end: theme.colorScheme.outline),
              bubblesColor: BubblesColor(
                dotPrimaryColor: theme.colorScheme.outline,
                dotSecondaryColor: theme.colorScheme.onPrimary,
              ),
              likeBuilder: (bool isLiked) {
                return Icon(
                  isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  color: theme.colorScheme.onPrimary,
                  size: AppSizes.kiconSize,
                );
              },
              likeCount: 665,
              countBuilder: (int? count, bool isLiked, String text) {
                return Text(
                  text,
                  style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onPrimary),
                );
              },

            ),
            const Spacer(),
            TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: theme.colorScheme.onPrimary,
                  foregroundColor: theme.colorScheme.onBackground,
                  shape: const StadiumBorder(),
                ),
                icon: Icon(Platform.isAndroid ? Icons.share : Icons.ios_share),
                label: Text("318",style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.onBackground))),*/
          ],
        ),
      ),
    );
  }
}
