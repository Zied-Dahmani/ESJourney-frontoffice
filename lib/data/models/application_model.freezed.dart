// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Application _$ApplicationFromJson(Map<String, dynamic> json) {
  return _Application.fromJson(json);
}

/// @nodoc
mixin _$Application {
  dynamic get id => throw _privateConstructorUsedError;
  dynamic get userId => throw _privateConstructorUsedError;
  ApplicationState get state => throw _privateConstructorUsedError;
  Club get club => throw _privateConstructorUsedError;
  DateTime get dateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplicationCopyWith<Application> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationCopyWith<$Res> {
  factory $ApplicationCopyWith(
          Application value, $Res Function(Application) then) =
      _$ApplicationCopyWithImpl<$Res, Application>;
  @useResult
  $Res call(
      {dynamic id,
      dynamic userId,
      ApplicationState state,
      Club club,
      DateTime dateTime});

  $ClubCopyWith<$Res> get club;
}

/// @nodoc
class _$ApplicationCopyWithImpl<$Res, $Val extends Application>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? state = null,
    Object? club = null,
    Object? dateTime = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ApplicationState,
      club: null == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as Club,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClubCopyWith<$Res> get club {
    return $ClubCopyWith<$Res>(_value.club, (value) {
      return _then(_value.copyWith(club: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ApplicationCopyWith<$Res>
    implements $ApplicationCopyWith<$Res> {
  factory _$$_ApplicationCopyWith(
          _$_Application value, $Res Function(_$_Application) then) =
      __$$_ApplicationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      dynamic userId,
      ApplicationState state,
      Club club,
      DateTime dateTime});

  @override
  $ClubCopyWith<$Res> get club;
}

/// @nodoc
class __$$_ApplicationCopyWithImpl<$Res>
    extends _$ApplicationCopyWithImpl<$Res, _$_Application>
    implements _$$_ApplicationCopyWith<$Res> {
  __$$_ApplicationCopyWithImpl(
      _$_Application _value, $Res Function(_$_Application) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userId = freezed,
    Object? state = null,
    Object? club = null,
    Object? dateTime = null,
  }) {
    return _then(_$_Application(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as ApplicationState,
      club: null == club
          ? _value.club
          : club // ignore: cast_nullable_to_non_nullable
              as Club,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Application extends _Application {
  const _$_Application(
      {required this.id,
      required this.userId,
      required this.state,
      required this.club,
      required this.dateTime})
      : super._();

  factory _$_Application.fromJson(Map<String, dynamic> json) =>
      _$$_ApplicationFromJson(json);

  @override
  final dynamic id;
  @override
  final dynamic userId;
  @override
  final ApplicationState state;
  @override
  final Club club;
  @override
  final DateTime dateTime;

  @override
  String toString() {
    return 'Application(id: $id, userId: $userId, state: $state, club: $club, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Application &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.club, club) || other.club == club) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(userId),
      state,
      club,
      dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApplicationCopyWith<_$_Application> get copyWith =>
      __$$_ApplicationCopyWithImpl<_$_Application>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApplicationToJson(
      this,
    );
  }
}

abstract class _Application extends Application {
  const factory _Application(
      {required final dynamic id,
      required final dynamic userId,
      required final ApplicationState state,
      required final Club club,
      required final DateTime dateTime}) = _$_Application;
  const _Application._() : super._();

  factory _Application.fromJson(Map<String, dynamic> json) =
      _$_Application.fromJson;

  @override
  dynamic get id;
  @override
  dynamic get userId;
  @override
  ApplicationState get state;
  @override
  Club get club;
  @override
  DateTime get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$_ApplicationCopyWith<_$_Application> get copyWith =>
      throw _privateConstructorUsedError;
}
