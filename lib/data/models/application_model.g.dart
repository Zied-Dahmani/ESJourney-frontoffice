// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Application _$$_ApplicationFromJson(Map<String, dynamic> json) =>
    _$_Application(
      id: json['id'],
      userId: json['userId'],
      state: $enumDecode(_$ApplicationStateEnumMap, json['state']),
      club: Club.fromJson(json['club'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ApplicationToJson(_$_Application instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'state': _$ApplicationStateEnumMap[instance.state]!,
      'club': instance.club,
    };

const _$ApplicationStateEnumMap = {
  ApplicationState.waiting: 'waiting',
  ApplicationState.underReview: 'underReview',
  ApplicationState.accepted: 'accepted',
  ApplicationState.denied: 'denied',
};
