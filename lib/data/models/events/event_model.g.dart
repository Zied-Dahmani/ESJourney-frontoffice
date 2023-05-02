// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['_id'] as String,
      title: json['title'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
      type: json['type'] as String,
      eventImage: json['eventImage'] as String,
      location: json['location'] as String,
      requirementsDescription: json['requirementsDescription'] as String,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'description': instance.description,
      'isDone': instance.isDone,
      'type': instance.type,
      'eventImage': instance.eventImage,
      'location': instance.location,
      'requirementsDescription': instance.requirementsDescription,
    };
