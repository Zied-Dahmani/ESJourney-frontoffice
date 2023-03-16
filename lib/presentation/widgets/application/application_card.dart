import 'package:esjourney/data/models/application_model.dart';
import 'package:esjourney/data/models/application_state_enum.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({Key? key, required application}): _application = application, super(key: key);

  final Application _application;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: AppSizes.kcardHeight,
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace, vertical: AppSizes.ksmallSpace),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
            color: theme.colorScheme.background,
            boxShadow: [
              BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace, vertical: AppSizes.ksmallSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_application.club.name, style: theme.textTheme.headlineMedium),
                  Text(_application.state.name!, style: theme.textTheme.bodyMedium),
                  Text(_application.convertDate(), style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onTertiary)),
                ],
              ),
              Container(
                height: AppSizes.ksmallImageSize,
                width: AppSizes.ksmallImageSize,
                decoration: BoxDecoration(
                  color: theme.colorScheme.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                  image: DecorationImage(
                      image: NetworkImage('$kbaseUrl${_application.club.images[0]}'),
                      fit: BoxFit.fitHeight),
                ),
              )
                  .animate(
                delay: 1000.ms,
                onPlay: (controller) => controller.repeat(), // loop
              ).shimmer(
                delay: 1500.ms,
                duration: 1000.ms,
                stops: [0.0, 0.5, 1.0],
              ),
            ],
          ),
        ));
  }
}
