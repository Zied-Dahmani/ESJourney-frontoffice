import 'package:freezed_annotation/freezed_annotation.dart';
part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    DateTime? date,
    required String startTime,
    String? endTime,
    required String description,
    String? isDone,
    String? type,
    String? eventImage,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

/*import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String email,
    required String username,
    required String password,
    required String token,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}*/
