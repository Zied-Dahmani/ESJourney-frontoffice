import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubits/user/user_cubit.dart';
import '../../../../../logic/cubits/user/user_state.dart';
import '../../../../../utils/screen_size.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;
  String token = "";
  bool _isUpdateButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmNewPasswordController = TextEditingController();

    // Add listeners to the text controllers to update the button's enabled status
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Builder(
        builder: (context) {
          final userState = context.watch<UserCubit>().state;
          final user = userState is UserLogInSuccess ? userState.user : null;
          if (userState is UserLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userState is UserLogInSuccess) {
            token = userState.user.token!;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isUpdateButtonEnabled();
                      });
                    },
                    controller: _currentPasswordController,
                    decoration: const InputDecoration(
                      hintText: 'Old Password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: width * 0.05),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isUpdateButtonEnabled();
                      });
                    },
                    controller: _newPasswordController,
                    decoration: const InputDecoration(
                      hintText: 'New Password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: width * 0.05),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        isUpdateButtonEnabled();
                      });
                    },
                    controller: _confirmNewPasswordController,
                    decoration: const InputDecoration(
                      hintText: 'Confirm New Password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: width * 0.05),
                  ButtonWidget(
                    isDisabled: isUpdateButtonEnabled() ? false : true,
                    text: 'Update Password',
                    function: _updatePassword,
                  ),
                ],
              ),
            );
          } else if (userState is UserIsFailure) {
            return Center(
              child: Text(userState.error.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _updatePassword() {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmNewPassword = _confirmNewPasswordController.text;

    if (newPassword.length < 8) {
      // Password is too short
      showSnackBar(context, 'New password must be at least 8 characters long');
    } else if (newPassword != confirmNewPassword) {
      // Passwords do not match
      showSnackBar(context, 'Passwords do not match');
    } else {
      final userCubit = context.read<UserCubit>();

      // Call the updatePassword method
      userCubit.updatePassword(currentPassword, newPassword, token);

      // Listen for changes in the user state
      final passwordUpdateStream = userCubit.stream.where(
          (state) => state is UserLogInSuccess || state is UserIsFailure);

      // Show a progress indicator while waiting for the state to change
      showSnackBar(context, 'Updating password...');

      // Wait for the state to change
      passwordUpdateStream.first.then((state) {
        // Remove the progress indicator
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        if (state is UserLogInSuccess) {
          // Password updated successfully
          showSnackBar(context, 'Password updated successfully');

          Navigator.pop(context);
        } else if (state is UserIsFailure) {
          // Password update failed
          showSnackBar(context, state.error.toString());
        }
      });
    }
  }

  bool isUpdateButtonEnabled() {
    final currentPassword = _currentPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmNewPassword = _confirmNewPasswordController.text;
    return currentPassword.isNotEmpty &&
        newPassword.isNotEmpty &&
        confirmNewPassword.isNotEmpty;
  }
}
