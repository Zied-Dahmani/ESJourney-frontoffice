// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      id: json['_id'] as String,
      username: json['username'] as String,
      avatar: json['avatar'] as String,
      status: json['status'] as String,
      mediaContent: json['mediaContent'] as String?,
      createdAt: json['createdAt'] as int,
      likes: json['likes'] as int,
      likedBy:
          (json['likedBy'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
      'status': instance.status,
      'mediaContent': instance.mediaContent,
      'createdAt': instance.createdAt,
      'likes': instance.likes,
      'likedBy': instance.likedBy,
    };
