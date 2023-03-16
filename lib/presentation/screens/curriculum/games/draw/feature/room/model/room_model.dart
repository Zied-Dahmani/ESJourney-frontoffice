import 'package:freezed_annotation/freezed_annotation.dart';
part 'room_model.g.dart';

@JsonSerializable()
class RoomModel<T> {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'roomOwner')
  String? roomOwner;
  @JsonKey(name: 'connectedClients')
  List? players;

  RoomModel({
    this.id,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
