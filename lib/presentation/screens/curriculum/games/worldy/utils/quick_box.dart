import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/curriculum/games/worldy/provider/controller.dart';
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
              IconButton(
                onPressed: () {
                  Provider.of<Controller>(context,
                      listen: false).clearTiles();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<Controller>(context, listen: false).clearTiles();
                  Navigator.pop(context);
                  Navigator.restorablePushReplacementNamed(context, AppRoutes.wordlyGame);
                },
                icon: const Icon(Icons.replay),
              ),
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
