import 'dart:math';
import 'dart:ui';
import 'package:esjourney/presentation/widgets/club_event/ticket_type_card.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:flutter/material.dart';

class TicketType extends AnimatedWidget {
  const TicketType(
      {Key? key,
      required this.percent,
      required this.height,
      required this.depth,
      required this.image,
      required this.onCardSelected,
      this.verticalFactor = 0,
      required Animation<double> animation})
      : super(key: key, listenable: animation);

  get animation => listenable;

  final image, percent, height, depth, onCardSelected, verticalFactor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        top: height - depth * height / 2.0 * percent - (height / 4.0),
        child: Opacity(
          opacity: verticalFactor == 0 ? 1.0 : 1.0 - animation.value,
          child: Hero(
            tag: image,
            flightShuttleBuilder: (context, animation, flightDirection,
                fromHeroContext, toHeroContext) {
              Widget current;

              if (flightDirection == HeroFlightDirection.push) {
                current = toHeroContext.widget;
              } else {
                current = fromHeroContext.widget;
              }

              return AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) {
                    final newValue = lerpDouble(0.0, 2 * pi, animation.value);
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .001)
                        ..rotateX(newValue!),
                      child: current,
                    );
                  });
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate(
                    0.0,
                    verticalFactor *
                        animation.value *
                        ScreenSize.height(context),
                    depth * 50.0),
              child: GestureDetector(
                onTap: () => onCardSelected(),
                child: SizedBox(
                    height: height, child: TicketTypeCard(image: image)),
              ),
            ),
          ),
        ));
  }
}
