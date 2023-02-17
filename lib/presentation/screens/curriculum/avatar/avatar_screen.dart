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
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: CircularProgressIndicator());
                });
          } else if (state is UserLogInSuccess) {
            //Navigator.pop(dialogContext!);
            Navigator.of(context).pushNamed(AppRoutes.zoomDrawerScreen);
          } else if (state is UserIsFailure) {
            showScaffold(context, state.error);
          }
        },
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLogInSuccess) {
              return WebView(
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
                        final user2DUrl = '$api$userId''.png?scene=fullbody-posture-v1-transparent';
                        BlocProvider.of<UserCubit>(context).addAvatars(
                            state.user.token,user2DUrl, user3DUrl);

                      }
                    },
                  ),
                },
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
