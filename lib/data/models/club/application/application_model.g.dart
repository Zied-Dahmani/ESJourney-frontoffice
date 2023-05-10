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
      dateTime: DateTime.parse(json['dateTime'] as String),
      resume: json['resume'] as String,
      phoneNumber: json['phoneNumber'] as String,
      birthDate: json['birthDate'] as String,
      studyLevel: json['studyLevel'] as String,
      speciality: json['speciality'] as String,
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      linkedInLink: json['linkedInLink'] as String,
    );

Map<String, dynamic> _$$_ApplicationToJson(_$_Application instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'state': _$ApplicationStateEnumMap[instance.state]!,
      'club': instance.club,
      'dateTime': instance.dateTime.toIso8601String(),
      'resume': instance.resume,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate,
      'studyLevel': instance.studyLevel,
      'speciality': instance.speciality,
      'answers': instance.answers,
      'linkedInLink': instance.linkedInLink,
    };

const _$ApplicationStateEnumMap = {
  ApplicationState.waiting: 'waiting',
  ApplicationState.underReview: 'underReview',
  ApplicationState.accepted: 'accepted',
  ApplicationState.denied: 'denied',
};
