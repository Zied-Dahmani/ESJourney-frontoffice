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
      meeting: json['meeting'] == null
          ? null
          : MeetingDetail.fromJson(json['meeting'] as Map<String, dynamic>),
      polls: (json['polls'] as List<dynamic>?)
          ?.map((e) => Poll.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'meeting': instance.meeting,
      'polls': instance.polls,
    };
