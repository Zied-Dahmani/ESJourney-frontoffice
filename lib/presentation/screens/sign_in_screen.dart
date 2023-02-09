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
            Navigator.pop(dialogContext!);
            Navigator.of(context).pushNamed(AppRoutes.zoomDrawerScreen);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.ksignIn,
                    style: theme.textTheme.headlineLarge,
                  ),
                  Text(
                    AppStrings.ksubLogin,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  TextFormFieldWidget(_idController, Icons.person,
                      AppStrings.kid, TextInputType.number),
                  const SizedBox(height: AppSizes.ksmallSpace),
                  TextFormFieldWidget(_passwordController, Icons.lock,
                      AppStrings.kpassword, TextInputType.text),
                  const SizedBox(height: AppSizes.kbigSpace),
                  BlocBuilder<ConnectivityCubit, ConnectivityState>(
                    builder: (context, state) {
                      return Center(
                        child: ButtonWidget(
                            text: AppStrings.ksignIn,
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
