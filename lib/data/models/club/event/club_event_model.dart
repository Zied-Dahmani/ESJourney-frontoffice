import 'package:esjourney/data/models/club/event/club_event_type_enum.dart';
import 'package:esjourney/data/models/club/event/ticket_model.dart';
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
      required ClubEventType type,
      required List<String> timeline,
      required List<String> ticketTypeNames,
      required List<String> ticketTypeImages,
      required List<Ticket> tickets
      }) = _ClubEvent;

  factory ClubEvent.fromJson(Map<String, dynamic> json) =>
      _$ClubEventFromJson(json);

  String convertDate() => DateFormat('MMM d, h:mm a').format(dateTime);

}
