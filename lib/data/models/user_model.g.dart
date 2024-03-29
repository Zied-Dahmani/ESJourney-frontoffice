// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['_id'],
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      grade: json['grade'] as int,
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      coins: (json['coins'] as num).toDouble(),
      lastSeen: json['lastSeen'] as String,
      twoDAvatar: json['twoDAvatar'] as String?,
      threeDAvatar: json['threeDAvatar'] as String?,
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      online: json['online'] as bool,
      token: json['token'] as String?,
      fullName: json['fullName'] as String?,
      walletAddress: json['walletAddress'] as String?,
      privateKey: json['privateKey'] as String?,
      deviceToken: json['deviceToken'] as String?,
      score: json['score'] == null
          ? null
          : Score.fromJson(json['score'] as Map<String, dynamic>),
      achievement: json['achievement'] == null
          ? null
          : Achievement.fromJson(json['achievement'] as Map<String, dynamic>),
      achievements: (json['achievements'] as List<dynamic>?)
          ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'grade': instance.grade,
      'events': instance.events,
      'coins': instance.coins,
      'lastSeen': instance.lastSeen,
      'twoDAvatar': instance.twoDAvatar,
      'threeDAvatar': instance.threeDAvatar,
      'courses': instance.courses,
      'online': instance.online,
      'token': instance.token,
      'fullName': instance.fullName,
      'walletAddress': instance.walletAddress,
      'privateKey': instance.privateKey,
      'deviceToken': instance.deviceToken,
      'score': instance.score,
      'achievement': instance.achievement,
      'achievements': instance.achievements,
    };
