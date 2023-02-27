import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';




class EthQrCodeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      body:Builder(
        builder: (context) {
      final userState = context.watch<UserCubit>().state;


      if (userState is UserLogInSuccess) {
        List<String> myList = [userState.user.walletAddress!,userState.user.privateKey!] ;
        return Center(
          child:  QrImage(
            data: myList.join(","), // Convert list to comma-separated string
            version: QrVersions.auto,
            size: 200.0,
          )
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
      ),
    );
  }
}
