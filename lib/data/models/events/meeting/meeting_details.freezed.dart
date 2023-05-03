// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meeting_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MeetingDetail _$MeetingDetailFromJson(Map<String, dynamic> json) {
  return _MeetingDetail.fromJson(json);
}

/// @nodoc
mixin _$MeetingDetail {
  String? get id => throw _privateConstructorUsedError;
  String? get hostId => throw _privateConstructorUsedError;
  String? get hostName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingDetailCopyWith<MeetingDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingDetailCopyWith<$Res> {
  factory $MeetingDetailCopyWith(
          MeetingDetail value, $Res Function(MeetingDetail) then) =
      _$MeetingDetailCopyWithImpl<$Res, MeetingDetail>;
  @useResult
  $Res call({String? id, String? hostId, String? hostName});
}

/// @nodoc
class _$MeetingDetailCopyWithImpl<$Res, $Val extends MeetingDetail>
    implements $MeetingDetailCopyWith<$Res> {
  _$MeetingDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? hostId = freezed,
    Object? hostName = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      hostId: freezed == hostId
          ? _value.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String?,
      hostName: freezed == hostName
          ? _value.hostName
          : hostName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MeetingDetailCopyWith<$Res>
    implements $MeetingDetailCopyWith<$Res> {
  factory _$$_MeetingDetailCopyWith(
          _$_MeetingDetail value, $Res Function(_$_MeetingDetail) then) =
      __$$_MeetingDetailCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? hostId, String? hostName});
}

/// @nodoc
class __$$_MeetingDetailCopyWithImpl<$Res>
    extends _$MeetingDetailCopyWithImpl<$Res, _$_MeetingDetail>
    implements _$$_MeetingDetailCopyWith<$Res> {
  __$$_MeetingDetailCopyWithImpl(
      _$_MeetingDetail _value, $Res Function(_$_MeetingDetail) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? hostId = freezed,
    Object? hostName = freezed,
  }) {
    return _then(_$_MeetingDetail(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      hostId: freezed == hostId
          ? _value.hostId
          : hostId // ignore: cast_nullable_to_non_nullable
              as String?,
      hostName: freezed == hostName
          ? _value.hostName
          : hostName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MeetingDetail implements _MeetingDetail {
  const _$_MeetingDetail({this.id, this.hostId, this.hostName});

  factory _$_MeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$$_MeetingDetailFromJson(json);

  @override
  final String? id;
  @override
  final String? hostId;
  @override
  final String? hostName;

  @override
  String toString() {
    return 'MeetingDetail(id: $id, hostId: $hostId, hostName: $hostName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MeetingDetail &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.hostId, hostId) || other.hostId == hostId) &&
            (identical(other.hostName, hostName) ||
                other.hostName == hostName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, hostId, hostName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MeetingDetailCopyWith<_$_MeetingDetail> get copyWith =>
      __$$_MeetingDetailCopyWithImpl<_$_MeetingDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MeetingDetailToJson(
      this,
    );
  }
}

abstract class _MeetingDetail implements MeetingDetail {
  const factory _MeetingDetail(
      {final String? id,
      final String? hostId,
      final String? hostName}) = _$_MeetingDetail;

  factory _MeetingDetail.fromJson(Map<String, dynamic> json) =
      _$_MeetingDetail.fromJson;

  @override
  String? get id;
  @override
  String? get hostId;
  @override
  String? get hostName;
  @override
  @JsonKey(ignore: true)
  _$$_MeetingDetailCopyWith<_$_MeetingDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
