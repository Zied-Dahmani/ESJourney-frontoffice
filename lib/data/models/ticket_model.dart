import 'package:freezed_annotation/freezed_annotation.dart';
part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
class Ticket with _$Ticket {
  const Ticket._();
  const factory Ticket({
    required String type,
    required int price,
    required String seat,
    required String barcode,
    required bool booked
  }) = _Ticket;

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

}
