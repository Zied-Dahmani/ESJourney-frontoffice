// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserCourse _$$_UserCourseFromJson(Map<String, dynamic> json) =>
    _$_UserCourse(
      id: json['id'],
      courseId: json['courseId'] as String,
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_UserCourseToJson(_$_UserCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'courseId': instance.courseId,
      'words': instance.words,
      'definitions': instance.definitions,
    };
