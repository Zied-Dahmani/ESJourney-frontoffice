import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class TimerCountdownContainer extends StatelessWidget {
  const TimerCountdownContainer({Key? key, this.deadline}) : super(key: key);

  final deadline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.kbigSpace, vertical: AppSizes.ksmallSpace),
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppSizes.kradius))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.kapplyWithin,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.colorScheme.onPrimary)),
          const Spacer(),
          TimerCountdown(
              spacerWidth: 3,
              timeTextStyle: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onPrimary, fontSize: 12),
              descriptionTextStyle: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onPrimary, fontSize: 12),
              colonsTextStyle: theme.textTheme.bodySmall!
                  .copyWith(color: theme.colorScheme.onPrimary, fontSize: 12),
              format: CountDownTimerFormat.daysHoursMinutesSeconds,
              endTime: deadline),
        ],
      ),
    );
  }
}
