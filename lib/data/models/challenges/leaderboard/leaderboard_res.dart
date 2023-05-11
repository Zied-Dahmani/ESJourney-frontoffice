
import 'package:esjourney/data/models/challenges/score/score_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'leaderboard_res.freezed.dart';
part 'leaderboard_res.g.dart';
@freezed
class LeaderboardRes with _$LeaderboardRes {
  const factory LeaderboardRes({
    required String username,
    required Score score,
     String? twoDAvatar
  }) = _LeaderboardRes;

  factory LeaderboardRes.fromJson(Map<String, dynamic> json) => _$LeaderboardResFromJson(json);
}
