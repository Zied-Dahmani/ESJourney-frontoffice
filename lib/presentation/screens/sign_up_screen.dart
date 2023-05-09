import 'dart:async';

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

import '../../logic/cubits/user/username_available/username_available_cubit.dart';
import '../../logic/cubits/user/username_available/username_available_state.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  BuildContext? dialogContext;
  late final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    IconData? icon;
    final _debouncer = Debouncer(const Duration(milliseconds: 500));

    final theme = Theme.of(context);
    return Scaffold(

      body: Builder(
        builder: (context) {
          final userState = context.watch<UserCubit>().state;
          final usernameAvailableState =
              context.watch<UsernameAvailableCubit>().state;

          if (usernameAvailableState is UsernameAvailableLoadInProgress) {
            _isLoading.value = true;

          } else if (usernameAvailableState is UsernameAvailableSuccess) {
            icon =
                usernameAvailableState.isAvailable ? Icons.check : Icons.close;
            _isLoading.value = false;

          } else if (usernameAvailableState is UsernameAvailableIsFailure) {
            _isLoading.value = false;
            print("failure");
          } else if (usernameAvailableState is UsernameAvailableInitial) {
            _isLoading.value = false;
            print("initial");
          }
          if (userState is UserLoadInProgress) {
            showDialog(
                context: context,
                builder: (context) {
                  dialogContext = context;
                  return const Center(child: CircularProgressIndicator());
                });
          } else if (userState is UserLogInSuccess) {
            //Navigator.pop(dialogContext!);
            Provider.of<SocketService>(context, listen: false)
                .connect(userState.user.token!);
            Navigator.of(context).pushNamed(AppRoutes.avatar);
          } else if (userState is UserIsFailure) {
            Navigator.pop(dialogContext!);
            showScaffold(context, userState.error);
          }

          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.kbigSpace,
                  vertical: AppSizes.khugeSpace),
              color: theme.colorScheme.background,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: AppSizes.khugeSpace),
                    Image.asset(
                      'assets/images/app_logo.png',
                      height: AppSizes.khugeImageSize,
                      width: AppSizes.khugeImageSize,
                    ),
                    Text(
                      AppStrings.ksignUpPrompt,
                      style: theme.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSizes.ksmallSpace),
                    Text(
                      AppStrings.ksignUpPrompt2,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSizes.khugeSpace),
                ValueListenableBuilder<bool>(
                  valueListenable: _isLoading,
                  builder: (context, value, child) =>


                    TextFormFieldWidget(
                      _idController,
                      AppStrings.kusername,
                      TextInputType.name,
                      isLoading:     _isLoading.value,
                      icon: icon,
                      onChanged: (value) async {
    _debouncer.run(() async {
                        if (value.isNotEmpty) {
                          _isLoading.value = true;
                        await   Future.delayed(const Duration(milliseconds: 2000));
                          print("here 1 ");
                          BlocProvider.of<UsernameAvailableCubit>(context)
                              .checkUsername(value);
                        }
                        } );
                      },
                    ),
                ),

                    const SizedBox(height: AppSizes.kbigSpace),
                    TextFormFieldWidget(_emailController, AppStrings.kemail,
                        TextInputType.name),
                    const SizedBox(height: AppSizes.kbigSpace),
                    TextFormFieldWidget(_passwordController,
                        AppStrings.kpassword, TextInputType.visiblePassword),
                    const SizedBox(height: AppSizes.kbigSpace),
                    BlocBuilder<ConnectivityCubit, ConnectivityState>(
                      builder: (context, state) {
                        return Center(
                          child: ButtonWidget(
                              text: AppStrings.ksignUp,
                              function: () {
                                if (_formKey.currentState!.validate()) {
                                  if (state is ConnectivityConnectSuccess) {
                                    BlocProvider.of<UserCubit>(context).signUp(
                                        _idController.text,
                                        _emailController.text,
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
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.kalreadyHaveAnAccount,
                            style: theme.textTheme.bodyMedium,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.signInScreen);
                            },
                            child: Text(
                              AppStrings.ksignIn,
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: theme.colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}