// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ClubEvent _$ClubEventFromJson(Map<String, dynamic> json) {
  return _ClubEvent.fromJson(json);
}

/// @nodoc
mixin _$ClubEvent {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;
  List<double> get latLng => throw _privateConstructorUsedError;
  List<String> get timeline => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubEventCopyWith<ClubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubEventCopyWith<$Res> {
  factory $ClubEventCopyWith(ClubEvent value, $Res Function(ClubEvent) then) =
      _$ClubEventCopyWithImpl<$Res, ClubEvent>;
  @useResult
  $Res call(
      {dynamic id,
      String name,
      String image,
      String description,
      DateTime dateTime,
      List<double> latLng,
      List<String> timeline});
}

/// @nodoc
class _$ClubEventCopyWithImpl<$Res, $Val extends ClubEvent>
    implements $ClubEventCopyWith<$Res> {
  _$ClubEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? image = null,
    Object? description = null,
    Object? dateTime = null,
    Object? latLng = null,
    Object? timeline = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as List<double>,
      timeline: null == timeline
          ? _value.timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClubEventCopyWith<$Res> implements $ClubEventCopyWith<$Res> {
  factory _$$_ClubEventCopyWith(
          _$_ClubEvent value, $Res Function(_$_ClubEvent) then) =
      __$$_ClubEventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      String name,
      String image,
      String description,
      DateTime dateTime,
      List<double> latLng,
      List<String> timeline});
}

/// @nodoc
class __$$_ClubEventCopyWithImpl<$Res>
    extends _$ClubEventCopyWithImpl<$Res, _$_ClubEvent>
    implements _$$_ClubEventCopyWith<$Res> {
  __$$_ClubEventCopyWithImpl(
      _$_ClubEvent _value, $Res Function(_$_ClubEvent) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? image = null,
    Object? description = null,
    Object? dateTime = null,
    Object? latLng = null,
    Object? timeline = null,
  }) {
    return _then(_$_ClubEvent(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      latLng: null == latLng
          ? _value._latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as List<double>,
      timeline: null == timeline
          ? _value._timeline
          : timeline // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClubEvent extends _ClubEvent {
  const _$_ClubEvent(
      {required this.id,
      required this.name,
      required this.image,
      required this.description,
      required this.dateTime,
      required final List<double> latLng,
      required final List<String> timeline})
      : _latLng = latLng,
        _timeline = timeline,
        super._();

  factory _$_ClubEvent.fromJson(Map<String, dynamic> json) =>
      _$$_ClubEventFromJson(json);

  @override
  final dynamic id;
  @override
  final String name;
  @override
  final String image;
  @override
  final String description;
  @override
  final DateTime dateTime;
  final List<double> _latLng;
  @override
  List<double> get latLng {
    if (_latLng is EqualUnmodifiableListView) return _latLng;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_latLng);
  }

  final List<String> _timeline;
  @override
  List<String> get timeline {
    if (_timeline is EqualUnmodifiableListView) return _timeline;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timeline);
  }

  @override
  String toString() {
    return 'ClubEvent(id: $id, name: $name, image: $image, description: $description, dateTime: $dateTime, latLng: $latLng, timeline: $timeline)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClubEvent &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            const DeepCollectionEquality().equals(other._latLng, _latLng) &&
            const DeepCollectionEquality().equals(other._timeline, _timeline));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      image,
      description,
      dateTime,
      const DeepCollectionEquality().hash(_latLng),
      const DeepCollectionEquality().hash(_timeline));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubEventCopyWith<_$_ClubEvent> get copyWith =>
      __$$_ClubEventCopyWithImpl<_$_ClubEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClubEventToJson(
      this,
    );
  }
}

abstract class _ClubEvent extends ClubEvent {
  const factory _ClubEvent(
      {required final dynamic id,
      required final String name,
      required final String image,
      required final String description,
      required final DateTime dateTime,
      required final List<double> latLng,
      required final List<String> timeline}) = _$_ClubEvent;
  const _ClubEvent._() : super._();

  factory _ClubEvent.fromJson(Map<String, dynamic> json) =
      _$_ClubEvent.fromJson;

  @override
  dynamic get id;
  @override
  String get name;
  @override
  String get image;
  @override
  String get description;
  @override
  DateTime get dateTime;
  @override
  List<double> get latLng;
  @override
  List<String> get timeline;
  @override
  @JsonKey(ignore: true)
  _$$_ClubEventCopyWith<_$_ClubEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
