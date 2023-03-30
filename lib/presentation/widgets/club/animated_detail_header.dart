import 'dart:ui';
import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/presentation/animations/club/translate_animation.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/club/club_images_page_view.dart';
import 'package:esjourney/presentation/widgets/club/like_and_share_container.dart';
import 'package:esjourney/presentation/widgets/club/timer_countdown_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedDetailHeader extends StatelessWidget {
  AnimatedDetailHeader(
      {Key? key,
      required this.club,
      required this.bottomPercent,
      required this.topPercent})
      : super(key: key);

  var club;
  final double bottomPercent, topPercent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: (20 + MediaQuery.of(context).padding.top) *
                      (1 - bottomPercent),
                  bottom: 160 * (1 - bottomPercent)),
              child: Transform.scale(
                scale: lerpDouble(1, 1.3, bottomPercent),
                child: ClubImagesPageView(images: club.images),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: -60 * (1 - bottomPercent),
              child: BackButton(
                onPressed: () {
                  if (BlocProvider.of<ClubCubit>(context).clubId != '') {
                    Navigator.of(context).pushNamed(AppRoutes.zoomDrawerScreen);
                  } else {
                    Navigator.pop(context);
                  }
                },
                color: theme.colorScheme.onPrimary,
              ),
            ),
            Positioned(
              top: lerpDouble(-100, 140, topPercent)!
                  .clamp(MediaQuery.of(context).padding.top + 11, 140.0),
              left: lerpDouble(60, 30, topPercent)!.clamp(20.0, 50.0),
              child: AnimatedOpacity(
                duration: kThemeAnimationDuration,
                opacity: bottomPercent < 1 ? 0 : 1,
                child: Text(
                  club.name,
                  style: theme.textTheme.headlineLarge!.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontSize: lerpDouble(20, 40, topPercent),
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
        Positioned.fill(
            top: null,
            bottom: -140 * (1 - topPercent),
            child: TranslateAnimation(
                child: TimerCountdownContainer(deadline: club.deadline))),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(color: theme.colorScheme.background, height: 10),
        ),
        Positioned.fill(
            top: null,
            child: TranslateAnimation(
              child: LikeAndShareContainer(club: club),
            )),
      ],
    );
  }
}
