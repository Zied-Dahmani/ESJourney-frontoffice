// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClubEvent _$$_ClubEventFromJson(Map<String, dynamic> json) => _$_ClubEvent(
      id: json['id'],
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      latLng: (json['latLng'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      timeline:
          (json['timeline'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ClubEventToJson(_$_ClubEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'description': instance.description,
      'dateTime': instance.dateTime.toIso8601String(),
      'latLng': instance.latLng,
      'timeline': instance.timeline,
    };
