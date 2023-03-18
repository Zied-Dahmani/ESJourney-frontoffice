// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel<T> _$RoomModelFromJson<T>(Map<String, dynamic> json) => RoomModel<T>(
      id: json['id'] as String?,
    )
      ..roomOwner = json['roomOwner'] as String?
      ..players = json['connectedClients'] as List<dynamic>?;

Map<String, dynamic> _$RoomModelToJson<T>(RoomModel<T> instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomOwner': instance.roomOwner,
      'connectedClients': instance.players,
    };
