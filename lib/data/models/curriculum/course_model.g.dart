// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Course _$$_CourseFromJson(Map<String, dynamic> json) => _$_Course(
      id: json['_id'],
      module: json['module'] as String,
      title: json['title'] as String,
      grade: json['grade'] as int,
      estimatedTime: json['estimatedTime'] as String,
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_CourseToJson(_$_Course instance) => <String, dynamic>{
      '_id': instance.id,
      'module': instance.module,
      'title': instance.title,
      'grade': instance.grade,
      'estimatedTime': instance.estimatedTime,
      'words': instance.words,
      'definitions': instance.definitions,
    };
