// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leaderboard_res.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LeaderboardRes _$LeaderboardResFromJson(Map<String, dynamic> json) {
  return _LeaderboardRes.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardRes {
  String get username => throw _privateConstructorUsedError;
  Score get score => throw _privateConstructorUsedError;
  String? get twoDAvatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderboardResCopyWith<LeaderboardRes> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardResCopyWith<$Res> {
  factory $LeaderboardResCopyWith(
          LeaderboardRes value, $Res Function(LeaderboardRes) then) =
      _$LeaderboardResCopyWithImpl<$Res, LeaderboardRes>;
  @useResult
  $Res call({String username, Score score, String? twoDAvatar});

  $ScoreCopyWith<$Res> get score;
}

/// @nodoc
class _$LeaderboardResCopyWithImpl<$Res, $Val extends LeaderboardRes>
    implements $LeaderboardResCopyWith<$Res> {
  _$LeaderboardResCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? score = null,
    Object? twoDAvatar = freezed,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score,
      twoDAvatar: freezed == twoDAvatar
          ? _value.twoDAvatar
          : twoDAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScoreCopyWith<$Res> get score {
    return $ScoreCopyWith<$Res>(_value.score, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_LeaderboardResCopyWith<$Res>
    implements $LeaderboardResCopyWith<$Res> {
  factory _$$_LeaderboardResCopyWith(
          _$_LeaderboardRes value, $Res Function(_$_LeaderboardRes) then) =
      __$$_LeaderboardResCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, Score score, String? twoDAvatar});

  @override
  $ScoreCopyWith<$Res> get score;
}

/// @nodoc
class __$$_LeaderboardResCopyWithImpl<$Res>
    extends _$LeaderboardResCopyWithImpl<$Res, _$_LeaderboardRes>
    implements _$$_LeaderboardResCopyWith<$Res> {
  __$$_LeaderboardResCopyWithImpl(
      _$_LeaderboardRes _value, $Res Function(_$_LeaderboardRes) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? score = null,
    Object? twoDAvatar = freezed,
  }) {
    return _then(_$_LeaderboardRes(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score,
      twoDAvatar: freezed == twoDAvatar
          ? _value.twoDAvatar
          : twoDAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LeaderboardRes implements _LeaderboardRes {
  const _$_LeaderboardRes(
      {required this.username, required this.score, this.twoDAvatar});

  factory _$_LeaderboardRes.fromJson(Map<String, dynamic> json) =>
      _$$_LeaderboardResFromJson(json);

  @override
  final String username;
  @override
  final Score score;
  @override
  final String? twoDAvatar;

  @override
  String toString() {
    return 'LeaderboardRes(username: $username, score: $score, twoDAvatar: $twoDAvatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LeaderboardRes &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.twoDAvatar, twoDAvatar) ||
                other.twoDAvatar == twoDAvatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, score, twoDAvatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LeaderboardResCopyWith<_$_LeaderboardRes> get copyWith =>
      __$$_LeaderboardResCopyWithImpl<_$_LeaderboardRes>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LeaderboardResToJson(
      this,
    );
  }
}

abstract class _LeaderboardRes implements LeaderboardRes {
  const factory _LeaderboardRes(
      {required final String username,
      required final Score score,
      final String? twoDAvatar}) = _$_LeaderboardRes;

  factory _LeaderboardRes.fromJson(Map<String, dynamic> json) =
      _$_LeaderboardRes.fromJson;

  @override
  String get username;
  @override
  Score get score;
  @override
  String? get twoDAvatar;
  @override
  @JsonKey(ignore: true)
  _$$_LeaderboardResCopyWith<_$_LeaderboardRes> get copyWith =>
      throw _privateConstructorUsedError;
}
