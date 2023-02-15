import 'package:esjourney/presentation/screens/curriculum/games/worldy/provider/controller.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/screens/wordly_game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

runQuickBox({required BuildContext context, required String message}) {
  WidgetsBinding.instance.addPostFrameCallback(
    (timeStamp) {
      showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return AlertDialog(
            // content: ,
            actions: [
              IconButton(onPressed: (){
                print("pressed");
                Navigator.pop(context);
                Navigator.pop(context);
              }, icon: const Icon(Icons.close)),
              IconButton(onPressed: (){
                ChangeNotifierProvider(create: (_) => Controller());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const WordlyPage()),
                        (route) => false);
              }, icon: const Icon(Icons.replay)),

            ],
            title: Text(
              message,
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    },
  );
}
