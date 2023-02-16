import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingClubsList extends StatelessWidget {
  const LoadingClubsList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
      child: Shimmer.fromColors(
          baseColor: theme.colorScheme.tertiary,
          highlightColor: theme.colorScheme.onTertiary,
          enabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: AppSizes.kbigSpace),
                width: ScreenSize.width(context) / 1.4,
                height: ScreenSize.height(context) / 2,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: AppSizes.kbigSpace),
                width: AppSizes.kshimmerTextWidth,
                height: AppSizes.kshimmerTextHeight,
                color: theme.colorScheme.tertiary,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: AppSizes.ksmallSpace - 6),
                width: double.infinity,
                height: AppSizes.kshimmerTextHeight,
                color: theme.colorScheme.tertiary,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: AppSizes.ksmallSpace - 6),
                width: double.infinity,
                height: AppSizes.kshimmerTextHeight,
                color: theme.colorScheme.tertiary,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: AppSizes.kshimmerTextWidth,
                  height: AppSizes.kshimmerTextHeight,
                  color: theme.colorScheme.tertiary,
                ),
              )
            ],
          )),
    );
  }
}
