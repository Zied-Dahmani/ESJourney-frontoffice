
import 'package:esjourney/data/models/challenges/achievement/achievement_model.dart';
import 'package:esjourney/data/models/challenges/score/score_model.dart';
import 'package:esjourney/data/models/curriculum/user_course_model.dart';
import 'package:esjourney/data/models/events/event_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';



part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required dynamic id,
    required String username,
    required String email,
    required String password,
    required int grade,
    List<Event>? events,
    required double coins,
    required String lastSeen,
    String? twoDAvatar,
    String? threeDAvatar,
    List<UserCourse>? courses,
    required bool online,
    String? token,
    String? fullName,
    String? walletAddress,
    String? privateKey,
    String? deviceToken,
    Score? score,
    Achievement? achievement,
    List<Achievement>? achievements,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}