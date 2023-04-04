import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ClubInterviewScreen extends StatelessWidget {
  const ClubInterviewScreen({super.key, required this.callID, this.admin = false});

  final callID, admin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLogInSuccess) {
          return ZegoUIKitPrebuiltCall(
              appID: kzegoAppId,
              appSign: kzegoAppSign,
              userID: state.user.id,
              userName: state.user.username,
              callID: callID,
              // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
                ..onOnlySelfInRoom = (context) {
                  if (!admin) {
                    Navigator.of(context).pop();
                  }
                });
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
