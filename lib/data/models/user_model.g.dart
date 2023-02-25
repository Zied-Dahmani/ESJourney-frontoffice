// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['_id'],
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      grade: json['grade'] as int,
      coins: json['coins'] as int,
      twoDAvatar: json['twoDAvatar'] as String?,
      threeDAvatar: json['threeDAvatar'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => UserCourse.fromJson(e as Map<String, dynamic>))
          .toList(),
      online: json['online'] as bool,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      '_id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'grade': instance.grade,
      'coins': instance.coins,
      'twoDAvatar': instance.twoDAvatar,
      'threeDAvatar': instance.threeDAvatar,
      'courses': instance.courses,
      'online': instance.online,
      'token': instance.token,
    };
