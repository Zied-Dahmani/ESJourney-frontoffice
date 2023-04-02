
import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';
@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String name,
    required String image,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
}
