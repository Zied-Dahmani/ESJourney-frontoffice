// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Ticket _$$_TicketFromJson(Map<String, dynamic> json) => _$_Ticket(
      type: json['type'] as String,
      price: json['price'] as int,
      seat: json['seat'] as String,
      barcode: json['barcode'] as String,
      booked: json['booked'] as bool,
    );

Map<String, dynamic> _$$_TicketToJson(_$_Ticket instance) => <String, dynamic>{
      'type': instance.type,
      'price': instance.price,
      'seat': instance.seat,
      'barcode': instance.barcode,
      'booked': instance.booked,
    };
