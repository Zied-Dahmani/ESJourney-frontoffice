// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Game _$$_GameFromJson(Map<String, dynamic> json) => _$_Game(
      id: json['id'],
      title: json['title'] as String,
      words: (json['words'] as List<dynamic>).map((e) => e as String).toList(),
      definitions: (json['definitions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_GameToJson(_$_Game instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'words': instance.words,
      'definitions': instance.definitions,
    };
