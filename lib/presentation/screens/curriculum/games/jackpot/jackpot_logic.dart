import 'dart:math';

class JackpotLogic {
  int yourcoins = 100;
  bool coin10 = true;
  var reels = [0, 1, 2];

  var items = [
    "gfx-bell.png",
    "gfx-cherry.png",
    "gfx-coin.png",
    "gfx-grape.png",
    "gfx-seven.png",
    "gfx-strawberry.png"
  ];

  spin() {
    var spinammount = coin10 ? 10 : 20;
    if (spinammount <= yourcoins) {
      reels = List.generate(3, (_) => Random().nextInt(items.length));
      if (reels[0] == reels[1] && reels[0] == reels[2]) {
        if (coin10) {
          yourcoins = yourcoins + 10 * 10;
        } else {
          yourcoins = yourcoins + 20 * 10;
        }
        return 'WIN';
      } else {
        if (coin10) yourcoins = yourcoins - 10;
        if (!coin10) yourcoins = yourcoins - 20;
        if (yourcoins <= 0) {
          return 'GAME END';
        }
      }
    } else {
      return 'GAME END';
    }
  }

  reset() {
    yourcoins = 100;
  }
}
