import 'package:esjourney/logic/cubits/club/club_cubit.dart';
import 'package:esjourney/presentation/screens/club/club_screen.dart';
import 'package:esjourney/presentation/screens/curriculum/chat/socket_service.dart';
import 'package:esjourney/logic/cubits/connectivity/connectivity_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/text_form_field.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:esjourney/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/snackbar.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

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
        listener: (context, state) async {
          if (state is UserLoadInProgress) {
            showDialog(
                context: context,
                builder: (context) {
                  dialogContext = context;
                  return const Center(child: CircularProgressIndicator());
                });
          } else if (state is UserLogInSuccess) {
            Navigator.pop(dialogContext!);
            Provider.of<SocketService>(context, listen: false).connect(state.user.token!);
            if (BlocProvider.of<ClubCubit>(context).getClub() != null) {
              Navigator.of(context).pushNamed(AppRoutes.clubScreen,arguments: BlocProvider.of<ClubCubit>(context).getClub());
            }
            else {
              Navigator.of(context).pushNamed(AppRoutes.zoomDrawerScreen);
            }
          } else if (state is UserIsFailure) {
            Navigator.pop(dialogContext!);
            showSnackBar(context, state.error);
          }
        },
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.kbigSpace, vertical: AppSizes.khugeSpace),
            color: theme.colorScheme.background,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSizes.khugeSpace),
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: AppSizes.khugeImageSize,
                    width: AppSizes.khugeImageSize,
                  ),
                  Text(
                    AppStrings.ksignInPrompt,
                    style: theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppSizes.khugeSpace),
                  TextFormFieldWidget(
                      _idController, AppStrings.kusername, TextInputType.name),
                  const SizedBox(height: AppSizes.kbigSpace),
                  TextFormFieldWidget(_passwordController, AppStrings.kpassword,
                      TextInputType.visiblePassword),
                  const SizedBox(height: AppSizes.kbigSpace),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Text(AppStrings.kforgotPassword,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: theme.colorScheme.primary)),
                    ),
                  ),
                  const SizedBox(height: AppSizes.kbigSpace),
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                    builder: (context, state) {
                      return Center(
                        child: ButtonWidget(
                            text: AppStrings.klogin,
                            function: () {
                              if (_formKey.currentState!.validate()) {
                                if (state is ConnectivityConnectSuccess) {
                                 BlocProvider.of<UserCubit>(context).signIn(
                                      _idController.text,
                                      _passwordController.text);
                                } else {
                                  showSnackBar(
                                      context, kcheckInternetConnection);
                                }
                              }
                            }),
                      );
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.kdontHaveAccount,
                            style: theme.textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.signUpScreen);
                            },
                            child: Text(
                              AppStrings.ksignUp,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
