// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Application _$$_ApplicationFromJson(Map<String, dynamic> json) =>
    _$_Application(
      id: json['_id'],
      userId: json['userId'],
      state: $enumDecode(_$ApplicationStateEnumMap, json['state']),
      club: Club.fromJson(json['club'] as Map<String, dynamic>),
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$$_ApplicationToJson(_$_Application instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'state': _$ApplicationStateEnumMap[instance.state]!,
      'club': instance.club,
      'dateTime': instance.dateTime.toIso8601String(),
    };

const _$ApplicationStateEnumMap = {
  ApplicationState.waiting: 'waiting',
  ApplicationState.underReview: 'underReview',
  ApplicationState.accepted: 'accepted',
  ApplicationState.denied: 'denied',
};
