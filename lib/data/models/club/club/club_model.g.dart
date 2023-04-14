// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Club _$$_ClubFromJson(Map<String, dynamic> json) => _$_Club(
      id: json['id'],
      name: json['name'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      shortDescription: json['shortDescription'] as String,
      fullDescription: json['fullDescription'] as String,
      likes: json['likes'] as List<dynamic>,
      deadline: DateTime.parse(json['deadline'] as String),
      shorts:
          (json['shorts'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_ClubToJson(_$_Club instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'shortDescription': instance.shortDescription,
      'fullDescription': instance.fullDescription,
      'likes': instance.likes,
      'deadline': instance.deadline.toIso8601String(),
      'shorts': instance.shorts,
    };
