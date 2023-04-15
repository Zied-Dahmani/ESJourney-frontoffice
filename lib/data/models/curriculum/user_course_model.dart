import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_course_model.freezed.dart';

part 'user_course_model.g.dart';

@freezed
class UserCourse with _$UserCourse {
  const factory UserCourse({
    required dynamic id,
    required String courseId,
    required List<String> words,
    required List<String> definitions,
  }) = _UserCourse;

  factory UserCourse.fromJson(Map<String, dynamic> json) => _$UserCourseFromJson(json);
}
