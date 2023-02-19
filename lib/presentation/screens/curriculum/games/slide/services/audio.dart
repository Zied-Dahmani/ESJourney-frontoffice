import 'package:assets_audio_player/assets_audio_player.dart';

class AppAudio {
  Future<void> tileTransition() async {
    AssetsAudioPlayer.playAndForget(
      Audio('assets/images/curriculum/games/slide/sounds/transition.mp3', pitch: 1),
    );
  }

  Future<void> gameEnded() async {
    AssetsAudioPlayer.playAndForget(
        Audio('assets/images/curriculum/games/slide/sounds/cheering.mp3', pitch: 1));
  }

  Future<void> gameStarted() async {
    AssetsAudioPlayer.playAndForget(
        Audio('assets/images/curriculum/games/slide/sounds/game_start.mp3', pitch: 1));
  }

  Future<void> clockStart() async {
    AssetsAudioPlayer.playAndForget(Audio('assets/images/curriculum/games/slide/sounds/transition.mp3'));
  }
}
