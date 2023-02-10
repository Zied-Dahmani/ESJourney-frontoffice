// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Course _$$_CourseFromJson(Map<String, dynamic> json) => _$_Course(
      id: json['id'] as String,
      module: json['module'] as String,
      title: json['title'] as String,
      grade: json['grade'] as int,
      estimatedTime: json['estimatedTime'] as String,
      games: (json['games'] as List<dynamic>)
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_CourseToJson(_$_Course instance) => <String, dynamic>{
      'id': instance.id,
      'module': instance.module,
      'title': instance.title,
      'grade': instance.grade,
      'estimatedTime': instance.estimatedTime,
      'games': instance.games,
    };
