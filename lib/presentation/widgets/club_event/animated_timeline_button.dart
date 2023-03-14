import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedTimelineButton extends StatelessWidget {
  const AnimatedTimelineButton({Key? key, this.clubEvent}) : super(key: key);

  final clubEvent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.kbigSpace),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return Transform.scale(scale: value, child: child);
          },
          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.clubEventTicketsScreen, arguments: clubEvent);
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(FontAwesomeIcons.ticket,color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
        ),
      ),
    );
  }
}
