// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostItem _$$_PostItemFromJson(Map<String, dynamic> json) => _$_PostItem(
      status: json['status'] as String,
      mediaContent: json['mediaContent'] as String?,
      createdAt: json['createdAt'] as int,
    );

Map<String, dynamic> _$$_PostItemToJson(_$_PostItem instance) =>
    <String, dynamic>{
      'status': instance.status,
      'mediaContent': instance.mediaContent,
      'createdAt': instance.createdAt,
    };
