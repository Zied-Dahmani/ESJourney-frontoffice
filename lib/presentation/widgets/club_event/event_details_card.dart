import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EventDetailsCard extends StatelessWidget {
  const EventDetailsCard({
    Key? key,
    this.clubEvent,
    this.clubEventCubit,
  }) : super(key: key);

  final clubEvent, clubEventCubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.clubEventTimelineScreen, arguments: clubEvent),
      child: Container(
          margin: const EdgeInsets.all(AppSizes.kbigSpace),
          padding: const EdgeInsets.all(AppSizes.kbigSpace),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.secondary.withOpacity(.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: AppSizes.ksmallImageSize,
                    width: AppSizes.ksmallImageSize,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.tertiary,
                      borderRadius: const BorderRadius.all(Radius.circular(AppSizes.kradius)),
                      image: DecorationImage(image: NetworkImage('$kbaseUrl${clubEvent.image}'), fit: BoxFit.fitHeight),
                    ),
                  ).animate(
                    delay: 1000.ms,
                    onPlay: (controller) => controller.repeat(), // loop
                  ).shimmer(
                    delay: 1500.ms,
                    duration: 1000.ms,
                    stops: [0.0, 0.5, 1.0],
                  ),
                  const SizedBox(width: AppSizes.ksmallSpace),
                  Expanded(
                    child: Text(clubEvent.name,
                        style: theme.textTheme.bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
              Row(
                children: [
                  Text(clubEvent.convertDate(), style: theme.textTheme.bodySmall),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6.0),
                    child: IconButton(icon: Icon(FontAwesomeIcons.route,color: theme.colorScheme.primary), onPressed: () {
                      clubEventCubit.launchGoogleMaps(clubEvent.latLng[0], clubEvent.latLng[1]);
                    },),
                  ),
                ],
              ),
              Text(clubEvent.description,
                  style: theme.textTheme.bodySmall!
                      .copyWith(color: theme.colorScheme.tertiary,fontSize: 12))
            ],
          )),
    );
  }
}
