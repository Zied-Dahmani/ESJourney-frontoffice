import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  final ValueSetter setIndex;

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerItem(FontAwesomeIcons.house, AppStrings.khome, 0),
          DrawerItem(FontAwesomeIcons.calendarDays, AppStrings.kevents, 1),
          DrawerItem(FontAwesomeIcons.calendarDays, AppStrings.kclubEvents, 2),
          DrawerItem(FontAwesomeIcons.calendarDays, AppStrings.kmyEvents, 4),
          DrawerItem(FontAwesomeIcons.video, AppStrings.kapplications, 3),
          DrawerItem(Icons.person, AppStrings.kProfile, 5 )
        ],
      ),
    );
  }

  Widget DrawerItem(IconData icon, String text, int index) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.only(
            left: AppSizes.khugeSpace, bottom: AppSizes.ksmallSpace),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colorScheme.onPrimary,
            ),
            const SizedBox(width: AppSizes.ksmallSpace),
            Text(
              text,
              style: theme.textTheme.bodyMedium!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
