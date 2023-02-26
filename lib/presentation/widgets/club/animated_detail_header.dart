import 'dart:io';
import 'dart:ui';
import 'package:esjourney/presentation/screens/club/club_screen.dart';
import 'package:esjourney/presentation/widgets/club/club_images_page_view.dart';
import 'package:esjourney/presentation/widgets/club/like_and_share_container.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class AnimatedDetailHeader extends StatelessWidget {
  const AnimatedDetailHeader(
      {Key? key,
      required this.club,
      required this.bottomPercent,
      required this.topPercent})
      : super(key: key);

  final club;
  final double bottomPercent, topPercent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRect(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: (20 + MediaQuery.of(context).padding.top) *
                        (1 - bottomPercent),
                    bottom: 160 * (1 - bottomPercent)),
                child: Transform.scale(
                  scale: lerpDouble(1, 1.3, bottomPercent),
                  child: ClubImagesPageView(image: club.image),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top,
                left: -60 * (1 - bottomPercent),
                child: BackButton(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Positioned(
                top: lerpDouble(-100, 140, topPercent)!
                    .clamp(MediaQuery.of(context).padding.top + 8, 140.0),
                left: lerpDouble(60, 30, topPercent)!.clamp(20.0, 50.0),
                child: AnimatedOpacity(
                  duration: kThemeAnimationDuration,
                  opacity: bottomPercent < 1 ? 0 : 1,
                  child: Text(
                    club.name,
                    style: theme.textTheme.headlineLarge!.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontSize: lerpDouble(10, 40, topPercent),
                        shadows: [
                          Shadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 3.0,
                            color: theme.colorScheme.onBackground,
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned.fill(
            top: null,
            bottom: -140 * (1 - topPercent),
            // TODO Application deadline timer and rename it
            child: const TranslateAnimation(child: LikeAndShareContainer())),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(color: theme.colorScheme.background, height: 10),
        ),
        Positioned.fill(
            top: null,
            child: TranslateAnimation(
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.kbigSpace,
                    vertical: AppSizes.kbigSpace),
                decoration: BoxDecoration(
                    color: theme.colorScheme.background,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppSizes.kradius))),
                child: Row(
                  children: [
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
                          isLiked
                              ? FontAwesomeIcons.solidHeart
                              : FontAwesomeIcons.heart,
                          color: theme.colorScheme.primary,
                          size: AppSizes.kiconSize,
                        );
                      },
                      likeCount: 665,
                      countBuilder: (int? count, bool isLiked, String text) {
                        return Text(
                          text,
                          style: theme.textTheme.bodyMedium,
                        );
                      },
                    ),
                    const Spacer(),
                    IconButton(onPressed: (){}, icon: Icon(Platform.isAndroid ? Icons.share : Icons.ios_share,color: theme.colorScheme.primary,))
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
