import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({Key? key, required Marker marker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSizes.kbigSpace),
      child: Card(
        color: theme.colorScheme.background,
        child: Text(
          'dasdad',
          style: theme.textTheme.headlineLarge,
        ),
      ),
    );
  }
}
