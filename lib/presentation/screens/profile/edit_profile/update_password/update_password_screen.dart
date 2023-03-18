import 'package:esjourney/presentation/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/screen_size.dart';
import '../../../../widgets/snackbar.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;

  bool _isUpdateButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();

    // Add listeners to the text controllers to update the button's enabled status

  }

  @override
  void dispose() {

    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double width = ScreenSize.width(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (text) {
                setState(() {
                  isUpdateButtonEnabled();
                });

                print("qqqq " + isUpdateButtonEnabled().toString());
              },
              controller: _oldPasswordController,
              decoration: InputDecoration(
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
                print("qqqq " + isUpdateButtonEnabled().toString());
              },
              controller: _newPasswordController,
              decoration: InputDecoration(
                hintText: 'New Password',
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
      ),
    );
  }
    void _updatePassword() {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;

    if (newPassword.length < 8) {
      // Password is too short
      showSnackBar(
          context, 'New password must be at least 8 characters long');
    } else if (newPassword != oldPassword) {
      // Passwords do not match
      showSnackBar(context, 'Passwords do not match');

    } else {
      // Password update logic
      // TODO: implement password update logic
    }
  }


  bool isUpdateButtonEnabled() {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    return oldPassword.isNotEmpty && newPassword.isNotEmpty;
  }
}

