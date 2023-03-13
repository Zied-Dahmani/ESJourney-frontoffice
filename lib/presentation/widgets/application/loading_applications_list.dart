import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LoadingApplicationsList extends StatelessWidget {
  const LoadingApplicationsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      children: List.generate(
        6,
        (index) => Align(
          heightFactor: 0.7,
          alignment: Alignment.topCenter,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace, vertical: AppSizes.ksmallSpace),
              margin: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace, vertical: AppSizes.ksmallSpace),
              height: AppSizes.kcardHeight,
              decoration: BoxDecoration(
                    color: theme.colorScheme.tertiary,
                    border: Border.all(color: theme.colorScheme.onTertiary),
                    borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              3,
                              (index) => Container(
                                    margin: const EdgeInsets.symmetric(vertical: AppSizes.ksmallSpace),
                                    height: AppSizes.kshimmerTextHeight,
                                    width: ScreenSize.width(context) / 2.5,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.onTertiary,
                                      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                                    ),
                                  ))),
                      Container(
                        width: AppSizes.ksmallImageSize,
                        height: AppSizes.ksmallImageSize,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onTertiary,
                          borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                        ),
                      ),
                    ],
                  ))
              .animate(
            delay: 1000.ms,
            onPlay: (controller) => controller.repeat(), // loop
          ).shimmer(
            delay: 1500.ms,
            duration: 1000.ms,
            stops: [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
