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

  factory Event.fromJson(Map<String, dynamic> json) {
    final eventImage = json['eventImage'];
    print('eventImage = $eventImage');
    final location = json['location'];
    print('location = $location');
    final requirementsDescription = json['requirementsDescription'];
    print('requirementsDescription = $requirementsDescription');
    final isDone = json['isDone'];
    print('isDone = $isDone');
    final type = json['type'];
    print('type = $type');
    final description = json['description'];
    print('description = $description');
    final endTime = json['endTime'];
    print('endTime = $endTime');
    final startTime = json['startTime'];
    print('startTime = $startTime');
    final date = json['date'];
    print('date = $date');
    final title = json['title'];
    print('title = $title');
    final id = json['_id'];
    print('id = $id');
    return _$EventFromJson(json);
  }
}

