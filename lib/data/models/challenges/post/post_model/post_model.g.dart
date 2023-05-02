// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      username: json['username'] as String,
      avatar: json['avatar'] as String,
      posts: (json['posts'] as List<dynamic>)
          .map((e) => PostItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'username': instance.username,
      'avatar': instance.avatar,
      'posts': instance.posts,
    };
