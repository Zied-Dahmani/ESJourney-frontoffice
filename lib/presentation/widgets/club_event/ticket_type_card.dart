import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class TicketTypeCard extends StatelessWidget {
  const TicketTypeCard({Key? key, this.image, this.elevation=10.0}) : super(key: key);

  final image,elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PhysicalModel(
        elevation: elevation,
        borderRadius: BorderRadius.circular(AppSizes.kradius),
        color: theme.colorScheme.tertiary,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppSizes.kradius),
          child: Image.network('$kbaseUrl$image', fit: BoxFit.cover),
        ));
  }
}
