import 'package:esjourney/presentation/widgets/club_event/ticket_type_card.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';

class HorizontalTicketTypes extends StatelessWidget {
  const HorizontalTicketTypes({Key? key, this.clubEvent}) : super(key: key);

  final clubEvent;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSizes.kbigSpace, bottom: AppSizes.ksmallSpace),
          child: Text(AppStrings.klegend, style: theme.textTheme.headlineMedium),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: [
            const SizedBox(width: AppSizes.ksmallSpace),
            ...List.generate(
                clubEvent.ticketTypeImages.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.ksmallSpace),
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppSizes.kbigImageSize * .7,
                            width: ScreenSize.width(context) / 3,
                            child: TicketTypeCard(image:clubEvent.ticketTypeImages[index])
                          ),
                          const SizedBox(height: AppSizes.ksmallSpace),
                          Text(clubEvent.ticketTypeNames[index], style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    )),
                const SizedBox(width: AppSizes.ksmallSpace)
              ]),
        )
      ],
    );
  }
}
