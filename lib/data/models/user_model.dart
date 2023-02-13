import 'package:esjourney/data/models/curriculum/user_course_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String username,
    required String password,
    required int grade,
    required String token,
    required int coins,
    List<UserCourse>? courses,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}