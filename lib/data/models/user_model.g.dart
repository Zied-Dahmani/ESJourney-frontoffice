// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      grade: json['grade'] as int,
      coins: (json['coins'] as num).toDouble(),
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => UserCourse.fromJson(e as Map<String, dynamic>))
          .toList(),
      token: json['token'] as String?,
      score: json['score'] == null
          ? null
          : Score.fromJson(json['score'] as Map<String, dynamic>),
      walletAddress: json['walletAddress'] as String?,
      privateKey: json['privateKey'] as String?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'password': instance.password,
      'grade': instance.grade,
      'coins': instance.coins,
      'courses': instance.courses,
      'token': instance.token,
      'score': instance.score,
      'walletAddress': instance.walletAddress,
      'privateKey': instance.privateKey,
    };
