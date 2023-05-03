// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClubEvent _$$_ClubEventFromJson(Map<String, dynamic> json) => _$_ClubEvent(
      id: json['_id'],
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      latLng: (json['latLng'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      type: $enumDecode(_$ClubEventTypeEnumMap, json['type']),
      timeline:
          (json['timeline'] as List<dynamic>).map((e) => e as String).toList(),
      ticketTypeNames: (json['ticketTypeNames'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      ticketTypeImages: (json['ticketTypeImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
      walletAddress: json['walletAddress'] as String,
      privateKey: json['privateKey'] as String,
    );

Map<String, dynamic> _$$_ClubEventToJson(_$_ClubEvent instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'latLng': instance.latLng,
      'type': _$ClubEventTypeEnumMap[instance.type]!,
      'timeline': instance.timeline,
      'ticketTypeNames': instance.ticketTypeNames,
      'ticketTypeImages': instance.ticketTypeImages,
      'tickets': instance.tickets,
      'walletAddress': instance.walletAddress,
      'privateKey': instance.privateKey,
    };

const _$ClubEventTypeEnumMap = {
  ClubEventType.all: 'all',
  ClubEventType.teamBuilding: 'teamBuilding',
  ClubEventType.conference: 'conference',
  ClubEventType.charity: 'charity',
  ClubEventType.party: 'party',
};
