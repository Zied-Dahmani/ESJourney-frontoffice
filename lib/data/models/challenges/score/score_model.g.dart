// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Score _$$_ScoreFromJson(Map<String, dynamic> json) => _$_Score(
      weekly: (json['weekly'] as num).toDouble(),
      monthly: (json['monthly'] as num).toDouble(),
      allTime: (json['allTime'] as num).toDouble(),
    );

Map<String, dynamic> _$$_ScoreToJson(_$_Score instance) => <String, dynamic>{
      'weekly': instance.weekly,
      'monthly': instance.monthly,
      'allTime': instance.allTime,
    };
