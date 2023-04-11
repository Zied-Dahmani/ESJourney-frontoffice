import 'dart:io';
import 'package:awesome_card/credit_card.dart';
import 'package:awesome_card/extra/card_type.dart';
import 'package:awesome_card/style/card_background.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, this.page}) : super(key: key);

  final page;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(AppSizes.ksmallSpace),
        height: ScreenSize.height(context),
        width: ScreenSize.width(context),
        color: theme.colorScheme.primary,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: (1.0 - widget.page).clamp(0.0, 1.0),
          child: BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              if (state is UserLogInSuccess) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.ksmallSpace,
                          horizontal: AppSizes.ksmallSpace),
                      child: Text(AppStrings.kyourCard,
                          style: theme.textTheme.headlineMedium!
                              .copyWith(color: theme.colorScheme.onPrimary)),
                    ),
                    CreditCard(
                        height: 200,
                        cardNumber: "5450 7879 4864 7854",
                        cardExpiry: "10/25",
                        cardHolderName: state.user.fullName,
                        cvv: "456",
                        bankName: "Axis Bank",
                        cardType: CardType.masterCard,
                        // Optional if you want to override Card Type
                        showBackSide: false,
                        frontBackground: CardBackgrounds.white,
                        backBackground: CardBackgrounds.white,
                        showShadow: true,
                        textExpDate: 'Exp Date',
                        textName: 'Name',
                        textExpiry: 'MM/YY',
                        frontTextColor: theme.colorScheme.secondary,
                        backTextColor: theme.colorScheme.secondary),

                    /*Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.khugeSpace),
                      child: Center(
                        child: ButtonWidget(
                            backgroundColor: theme.colorScheme.outline,
                            text: AppStrings.kpay,
                            function: () {
                              //BlocProvider.of<ClubEventCubit>(context).bookEvent(state.user.coins);
                            }),
                      ),
                    ),*/
                    Padding(
                      padding:
                          const EdgeInsets.only(left: AppSizes.ksmallSpace,top: AppSizes.khugeSpace),
                      child: Text(AppStrings.kotherPaymentMethod,
                          style: theme.textTheme.headlineMedium!
                              .copyWith(color: theme.colorScheme.onPrimary)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: AppSizes.ksmallSpace,
                          vertical: AppSizes.ksmallSpace),
                      padding: const EdgeInsets.all(AppSizes.ksmallSpace),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSizes.kradius),
                          color: theme.colorScheme.onPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(80),
                                blurRadius: 10.0),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: AppSizes.ksmallImageSize,
                            width: AppSizes.ksmallImageSize,
                            margin: const EdgeInsets.only(
                                right: AppSizes.ksmallSpace),
                            child: Image.asset('assets/images/coins.gif'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppStrings.kesjCoins,
                                  style: theme.textTheme.bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text(AppStrings.kweb3,
                                  style: theme.textTheme.bodySmall),
                            ],
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: AppSizes.kiconSize * 1.7,
                              width: AppSizes.kiconSize * 1.7,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.kradius / 2),
                                color: theme.colorScheme.primary,
                              ),
                              child: Icon(
                                Platform.isAndroid
                                    ? Icons.arrow_forward
                                    : Icons.arrow_forward_ios_rounded,
                                color: theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
