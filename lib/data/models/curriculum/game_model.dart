import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_model.freezed.dart';

part 'game_model.g.dart';

@freezed
class Game with _$Game {
  const factory Game({
    required dynamic id,
    required String title,
    required List<String> words,
    required List<String> definitions,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}
