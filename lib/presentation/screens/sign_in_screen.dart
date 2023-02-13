import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/text_form_field.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/screen_size.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserLoadInProgress) {
            showDialog(
                context: context,
                builder: (context) {
                  dialogContext = context;
                  return const Center(child: CircularProgressIndicator());
                });
          } else if (state is UserLogInSuccess) {
            //Navigator.pop(dialogContext!);
              Navigator.of(context).pushNamed(AppRoutes.leaderboardScreen);

          } else if (state is UserIsFailure) {

            Navigator.pop(dialogContext!);
            showScaffold(context, state.error);
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kbigSpace,
                vertical: AppSizes.khugeSpace),
            color: theme.colorScheme.background,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScreenSize.height(context) * 0.05,
                  ),
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: ScreenSize.height(context) * 0.2,
                    width: ScreenSize.width(context) * 0.4,
                  ),
                  Text(
                    AppStrings.ksignInPrompt,
                    style: TextStyle(
                      color: theme.colorScheme.secondary,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'VisbyRoundCF',
                    ),
                  ),
                  SizedBox(
                    height: ScreenSize.height(context) * 0.08,
                  ), // Image

                  const SizedBox(height: AppSizes.ksmallSpace),
                  TextFormFieldWidget(_idController, AppStrings.kusername,
                      TextInputType.name),
                  const SizedBox(height: AppSizes.kbigSpace),
                  TextFormFieldWidget(_passwordController,
                      AppStrings.kpassword, TextInputType.visiblePassword),
                  const SizedBox(height: AppSizes.kbigSpace),
                  Container(
                    margin:
                    const EdgeInsets.only(right: AppSizes.ksmallSpace),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          AppStrings.kforgotPassword,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'VisbyRoundCF',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.kbigSpace),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                    builder: (context, state) {
                      return Center(
                        child: ButtonWidget(
                            height: ScreenSize.height(context) * 0.07,
                            width: ScreenSize.width(context) * 0.01,
                            backgroundColor: theme.colorScheme.primary,
                            text: AppStrings.klogin,
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                if (state is ConnectivityConnectSuccess) {
                                  BlocProvider.of<UserCubit>(context).signIn(
                                      _idController.text,
                                      _passwordController.text);
                                } else {
                                  showScaffold(
                                      context, kcheckInternetConnection);
                                }
                              }
                            }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showScaffold(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 2000),
    ));
  }
}
