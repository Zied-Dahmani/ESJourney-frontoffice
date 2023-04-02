import 'package:esjourney/presentation/widgets/button.dart';
import 'package:esjourney/presentation/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubits/user/user_cubit.dart';
import '../../../../../logic/cubits/user/user_state.dart';
import '../../../../../utils/screen_size.dart';

class UpdatePasswordBaseScreen extends StatefulWidget {
  const UpdatePasswordBaseScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordBaseScreen> createState() =>
      _UpdatePasswordBaseScreenState();
}

class _UpdatePasswordBaseScreenState extends State<UpdatePasswordBaseScreen> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmNewPasswordController;
  String token = "";

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

            return UpdatePasswordScreen(
              currentPasswordController: _currentPasswordController,
              newPasswordController: _newPasswordController,
              confirmNewPasswordController: _confirmNewPasswordController,
              updatePassword: () {
                _updatePassword();
              },
            );
          } else if (userState is UserIsFailure) {
            return UpdatePasswordScreen(
              currentPasswordController: _currentPasswordController,
              newPasswordController: _newPasswordController,
              confirmNewPasswordController: _confirmNewPasswordController,
              updatePassword: () {
                _updatePassword();
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  void _updatePassword() {
    final newPassword = _newPasswordController.text;
    final confirmNewPassword = _confirmNewPasswordController.text;

    if (newPassword.length < 8) {
      showSnackBar(context, 'New password must be at least 8 characters long');
      return;
    }

    if (newPassword != confirmNewPassword) {
      showSnackBar(context, 'Passwords do not match');
      return;
    }

    final userCubit = context.read<UserCubit>();
    userCubit.updatePassword(
        _currentPasswordController.text, newPassword, token);

    userCubit.stream
        .firstWhere(
            (state) => state is UserLogInSuccess || state is UserIsFailure)
        .then((state) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();

      if (state is UserLogInSuccess) {
        showSnackBar(context, 'Password updated successfully');
        Navigator.pop(context);
      } else if (state is UserIsFailure) {
        showSnackBar(context, state.error.toString());
      }
    });
  }
}

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({
    Key? key,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
    required this.updatePassword,
  }) : super(key: key);

  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final void Function() updatePassword;

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

late bool _isUpdateButtonEnabled ;

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isUpdateButtonEnabled() => _isUpdateButtonEnabled =
      widget.currentPasswordController.text.isNotEmpty &&
          widget.newPasswordController.text.isNotEmpty &&
          widget.confirmNewPasswordController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final double width = ScreenSize.width(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: (text) {
              print("3chqnged");
              setState(() {
                isUpdateButtonEnabled();
              });
            },
            controller: widget.currentPasswordController,
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
            controller: widget.newPasswordController,
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
            controller: widget.confirmNewPasswordController,
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
            function: widget.updatePassword,
          ),
        ],
      ),
    );
  }
}
