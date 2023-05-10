import 'dart:convert';

import 'package:esjourney/logic/cubits/user/user_cubit.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/presentation/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({Key? key}) : super(key: key);

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit,UserState>(
        listener: (context, state) {
          if (state is UserLoadInProgress) {
            print("here 1 ") ;
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
                });
          } else if (state is UserLogInSuccess) {
            print("here 2 ") ;
            Navigator.of(context).pushReplacementNamed(AppRoutes.zoomDrawerScreen);
          } else if (state is UserIsFailure) {
            print("here 3 ") ;
            print("errrrorr is ${state.error}");
            showScaffold(context, state.error);
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLogInSuccess) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) async {
                    await loadHtmlFromAssets(
                        controller, 'assets/html/curriculum/iframe.html');
                  },
                  javascriptChannels: {
                    JavascriptChannel(
                      name: 'AvatarCreated',
                      onMessageReceived: (JavascriptMessage message) async {
                        final data = message.message;
                        final Map<String, dynamic> json = jsonDecode(data);
                        const api = 'https://api.readyplayer.me/v1/avatars/';
                        if (json.isNotEmpty) {
                          final user3DUrl = json['data']['url'];
                          final userId = user3DUrl?.split('/').last.toString().replaceAll('.glb', '').trim();
                          final user2DUrl = '$api$userId''.png';
                          print('user2DUrl: $user2DUrl');
                          print('user3DUrl: $user3DUrl');
                          print(state.user.token!);
                          BlocProvider.of<UserCubit>(context).addAvatars(
                              state.user.token!,user2DUrl, user3DUrl);
                        }
                      },
                    ),
                  },
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  loadHtmlFromAssets(WebViewController controller, String asset) async {
    String fileText = await rootBundle.loadString(asset);
    controller.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  void showScaffold(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
      duration: const Duration(milliseconds: 2000),
    ));
  }
}
