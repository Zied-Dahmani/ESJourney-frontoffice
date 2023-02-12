// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      title: json['title'] as String,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String?,
      description: json['description'] as String,
      isDone: json['isDone'] as String?,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'title': instance.title,
      'date': instance.date?.toIso8601String(),
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'description': instance.description,
      'isDone': instance.isDone,
    };
