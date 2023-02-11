import 'package:freezed_annotation/freezed_annotation.dart';

import 'game_model.dart';

part 'course_model.freezed.dart';

part 'course_model.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    required dynamic id,
    required String module,
    required String title,
    required int grade,
    required String estimatedTime,
    required List<Game> games,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
