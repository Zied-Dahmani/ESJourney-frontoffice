// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LeaderboardRes _$$_LeaderboardResFromJson(Map<String, dynamic> json) =>
    _$_LeaderboardRes(
      username: json['username'] as String,
      score: Score.fromJson(json['score'] as Map<String, dynamic>),
      twoDAvatar: json['twoDAvatar'] as String?,
    );

Map<String, dynamic> _$$_LeaderboardResToJson(_$_LeaderboardRes instance) =>
    <String, dynamic>{
      'username': instance.username,
      'score': instance.score,
      'twoDAvatar': instance.twoDAvatar,
    };
