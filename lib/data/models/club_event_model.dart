import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
part 'club_event_model.freezed.dart';
part 'club_event_model.g.dart';

@freezed
class ClubEvent with _$ClubEvent {
  const ClubEvent._();
  const factory ClubEvent(
      {required dynamic id,
      required String name,
      required String image,
      required String description,
      required DateTime dateTime,
      required List<double> latLng,
      required List<String> timeline}) = _ClubEvent;

  factory ClubEvent.fromJson(Map<String, dynamic> json) =>
      _$ClubEventFromJson(json);

  String convertDate() => DateFormat('MMM d, h:mm a').format(dateTime);
}
