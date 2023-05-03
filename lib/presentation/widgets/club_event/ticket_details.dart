import 'package:esjourney/logic/cubits/club_event/club_event_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TicketDetails extends StatelessWidget {
  const TicketDetails({
    Key? key,
    this.clubEvent,
    this.ticketTypeIndex
  }) : super(key: key);

  final clubEvent, ticketTypeIndex;

  @override
  Widget build(BuildContext context) {
    final ticket = BlocProvider.of<ClubEventCubit>(context).ticket;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.ksmallSpace,
                  vertical: AppSizes.ksmallSpace * .5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.kradius),
                border: Border.all(width: 1.0, color: theme.colorScheme.outline),
              ),
              child: Center(
                child: Text(
                  clubEvent.ticketTypeNames[ticketTypeIndex],
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.outline),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: theme.colorScheme.primary,
                ),
                Text(
                (ticket?.price ?? 0).toString(),
                  style: theme.textTheme.headlineMedium,
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppSizes.kbigSpace),
          child: Text('${AppStrings.kevent} ${AppStrings.kticket}',
              style: theme.textTheme.headlineMedium),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSizes.kbigSpace,bottom: AppSizes.ksmallSpace),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<UserCubit, UserState>(
                    builder: (context, state) {
                      return state is UserLogInSuccess ?
                      titleSubTitleColumn(AppStrings.kowner, state.user.username,context)
                      : const SizedBox();
                    },
                  ),
                  titleSubTitleColumn(AppStrings.kdate, clubEvent.convertDate(), context),
                ],
              ),
            ),
            titleSubTitleColumn(AppStrings.kseat, ticket!.seat, context),
          ],
        ),
        const Spacer(),
        Center(
          child: Container(
            width: AppSizes.khugeImageSize,
            height: AppSizes.ksmallImageSize,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/barcode.png'),
                    fit: BoxFit.cover)),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.ksmallSpace),
            child: Text(ticket.barcode, style: theme.textTheme.bodyMedium),
          ),
        )
      ],
    );
  }
}

Widget titleSubTitleColumn(String title, String subtitle, BuildContext context) {
  final theme = Theme.of(context);
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: AppSizes.ksmallSpace),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.onTertiary),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height:AppSizes.ksmallSpace / 2),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ),
  );
}
