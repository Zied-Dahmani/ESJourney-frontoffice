import 'package:freezed_annotation/freezed_annotation.dart';

part 'score_model.freezed.dart';
part 'score_model.g.dart';

@freezed
class Score with _$Score {
  const factory Score({
    required double weekly,
    required double monthly,
    required double allTime,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}
