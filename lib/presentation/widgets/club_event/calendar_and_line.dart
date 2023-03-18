import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CalendarAndLine extends StatelessWidget {
  const CalendarAndLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: AppSizes.ktimeLineIcon,
      child: Column(
        children: [
          Icon(FontAwesomeIcons.solidCalendar, color: theme.colorScheme.primary, size: AppSizes.ktimeLineIcon),
          Expanded(child: Container(width: 5, color: theme.colorScheme.tertiary))
        ],
      ),
    );
  }
}
