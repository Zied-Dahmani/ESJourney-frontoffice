import 'package:esjourney/presentation/screens/curriculum/games/slide/enums/stage.dart';
import 'package:flutter/cupertino.dart';

class Navigation extends ChangeNotifier {
  Stage game = Stage.Casual;

  void switchStage(Stage stage, Function function) {
    if (stage != game) {
      game = stage;
      function();
      notifyListeners();
    }
  }
}
