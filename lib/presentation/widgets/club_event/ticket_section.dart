import 'package:esjourney/data/models/club/event/ticket_model.dart';
import 'package:esjourney/logic/cubits/club_event/club_event_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/club_event/ticket_details.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TicketSection extends StatelessWidget {
  const TicketSection(
      {Key? key,
      required this.verticalPos,
      required this.clubEvent,
      required this.ticketTypeIndex,
      required this.ticketIndex,
      required this.setStateRemainingTickets})
      : super(key: key);

  final verticalPos,
      clubEvent,
      ticketTypeIndex,
      ticketIndex,
      setStateRemainingTickets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: AppSizes.kbigSpace),
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.kbigSpace),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(AppSizes.kradius),
            ),
            child: Stack(
              children: [
                Center(child: header(context)),
                Opacity(
                  opacity:
                      (verticalPos / MediaQuery.of(context).size.height + .3)
                          .clamp(0.0, 1.0),
                  child: verticalPos > 250
                      ? Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenSize.height(context) / 1.2,
                                ),
                                TicketWidget(
                                  color: theme.colorScheme.onPrimary,
                                  width: ScreenSize.width(context),
                                  height: ScreenSize.height(context) / 1.5,
                                  isCornerRounded: true,
                                  padding:
                                      const EdgeInsets.all(AppSizes.kbigSpace),
                                  child: TicketDetails(
                                      clubEvent: clubEvent,
                                      ticketTypeIndex: ticketTypeIndex),
                                ),
                              ],
                            ),
                          ),
                        )
                      : null,
                )
              ],
            ),
          ),
        ),
        Container(
          height: AppSizes.kdividerHeight * 2,
          width: 50,
          margin: const EdgeInsets.only(
            top: AppSizes.ksmallSpace,
            bottom: AppSizes.kbigSpace,
          ),
          decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(AppSizes.kradius)),
        )
      ],
    );
  }

  Row header(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            text: AppStrings.kevent,
            style: theme.textTheme.headlineLarge!
                .copyWith(color: theme.colorScheme.onPrimary),
            children: [
              TextSpan(
                text: ' ${AppStrings.kticket}',
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return state is UserLogInSuccess
                ? SizedBox(
                    width: AppSizes.kiconSize * 3,
                    height: AppSizes.kiconSize * 2,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: AppSizes.kiconSize * 2,
                            width: AppSizes.kiconSize * 2,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onPrimary,
                              borderRadius:
                                  BorderRadius.circular(AppSizes.kradius * 2),
                            ),
                            child: Icon(FontAwesomeIcons.ticket,
                                color: theme.colorScheme.primary),
                          ),
                        ),
                        if (verticalPos == 0.0)
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                final ticket =
                                    BlocProvider.of<ClubEventCubit>(context)
                                        .ticket;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          theme.colorScheme.background,
                                      title: Text(AppStrings.kpayment,
                                          style:
                                              theme.textTheme.headlineMedium),
                                      content: Text(
                                          '${AppStrings.kpaymentConfirmation}${ticket.price}?',
                                          style: theme.textTheme.bodyMedium),
                                      actions: [
                                        TextButton(
                                            onPressed: () async {
                                              if (state.user.coins <= ticket.price) {
                                                Navigator.of(context).pop();
                                                showTopSnackBar(
                                                  Overlay.of(context)!,
                                                  const CustomSnackBar.error(
                                                    message: AppStrings
                                                        .knotEnoughMoney,
                                                  ),
                                                );
                                              } else {
                                                // final result = BlocProvider.of<
                                                //         UserCubit>(context)
                                                //     .bookEventWithETH(
                                                //         clubEvent.walletAddress,
                                                //         clubEvent.privateKey,
                                                //         ticket.price + 0.0,
                                                //         state.user.token!);
                                                //if (await result) {


                                                print(state.user.coins);
                                                final result2 = BlocProvider.of<
                                                        ClubEventCubit>(context)
                                                    .bookEvent(
                                                        state.user.token!,
                                                        clubEvent.id,
                                                        ticketIndex);
                                                if (await result2) {
                                                  setStateRemainingTickets();
                                                  BlocProvider.of<UserCubit>(context).sendNotif(clubEvent.name,'${state.user.username} ${AppStrings.khasBookedYourEvent}','c0qRt8q-RSGvGS_QQUNOU3:APA91bGxwESjj8igN-38WgZHHMtt4pBwGTKLAwVGee4cuVPzSxOA0wK202oHLcmMCZ93dvUBk-KpuFEg-GrdnTgkdt9toX08T2UYkrCzwXIHuh0ned0sZwoMp-PAg6raiW6KY5nGnxx5');
                                                  BlocProvider.of<ClubEventCubit>(context).init();
                                                  Navigator.of(context).pushNamed(AppRoutes.doneScreen);
                                                }
                                              }
                                            },
                                            // },
                                            child: Text(AppStrings.kyes,
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        color: theme.colorScheme
                                                            .outline))),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text(AppStrings.kno,
                                                style: theme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        color: theme.colorScheme
                                                            .error))),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: AppSizes.kiconSize * 2,
                                width: AppSizes.kiconSize * 2,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.outline,
                                  borderRadius: BorderRadius.circular(
                                      AppSizes.kradius * 2),
                                ),
                                child: Icon(FontAwesomeIcons.dollarSign,
                                    color: theme.colorScheme.onPrimary),
                              ),
                            ),
                          )
                      ],
                    ),
                  )
                : const SizedBox();
          },
        )
      ],
    );
  }
}
