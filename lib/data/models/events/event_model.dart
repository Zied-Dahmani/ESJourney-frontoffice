import 'package:freezed_annotation/freezed_annotation.dart';
part 'event_model.freezed.dart';
part 'event_model.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required DateTime date,
    required String startTime,
    required String endTime,
    required String description,
    required bool isDone,
    required String type,
    required String eventImage,
    required String location,
    required String requirementsDescription,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

}

