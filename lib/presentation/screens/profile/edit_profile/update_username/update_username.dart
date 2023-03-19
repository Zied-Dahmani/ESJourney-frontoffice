import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../logic/cubits/user/user_cubit.dart';
import '../../../../../logic/cubits/user/user_state.dart';
import '../../../../../utils/screen_size.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/snack_bar.dart';

class UpdateUsernameScreen extends StatefulWidget {
  const UpdateUsernameScreen({Key? key}) : super(key: key);

  @override
  State<UpdateUsernameScreen> createState() => _UpdateUsernameScreenState();
}

class _UpdateUsernameScreenState extends State<UpdateUsernameScreen> {
  late final TextEditingController _currentUsernameController;
  final _isButtonEnabled = ValueNotifier(false);

  String token = "";
  String currentUsername = "";
  String newUsername = "";

  @override
  void initState() {
    super.initState();
    _currentUsernameController = TextEditingController();
    _isButtonEnabled.value = false;

    // Add listeners to the text controllers to update the button's enabled status
  }

  @override
  void dispose() {
    _currentUsernameController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    print("rebuilt");
    return Scaffold(

      appBar: AppBar(
        title: const Text('Update Username'),
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
            currentUsername = userState.user.username;
            _currentUsernameController.text = user!.username;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    onChanged: (text) {
                      _isButtonEnabled.value = isUpdateButtonEnabled();
                      newUsername = text;
                    },
                    controller: _currentUsernameController,
                    maxLength: 30,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\d._]')),
                    ],
                    decoration: InputDecoration(
                      hintText: user!.username,
                      hintStyle: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: width * 0.04),
                  ValueListenableBuilder<bool>(
                    valueListenable: _isButtonEnabled,
                    builder: (context, isButtonEnabled, child) {
                      print("here ") ;
                      return ButtonWidget(
                        isDisabled: !isButtonEnabled,
                        text: 'Update Username',
                        function: _updateUsername,
                      );
                    },
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

  void _updateUsername() {

    final currentPassword = _currentUsernameController.text;

    final userCubit = context.read<UserCubit>();

    // Call the updatePassword method
    userCubit.updateUsername(currentPassword, token);

    // Listen for changes in the user state
    final usernameUpdateStream = userCubit.stream
        .where((state) => state is UserLogInSuccess || state is UserIsFailure);

    // Show a progress indicator while waiting for the state to change
    showSnackBar(context, 'Updating password...');

    // Wait for the state to change
    usernameUpdateStream.first.then((state) {
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

  bool isUpdateButtonEnabled() {
    final currentUsername = _currentUsernameController.text;
    return currentUsername.isNotEmpty &&
        currentUsername != this.currentUsername;
  }
}
