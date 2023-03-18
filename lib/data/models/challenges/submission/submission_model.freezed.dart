// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Submission _$SubmissionFromJson(Map<String, dynamic> json) {
  return _Submission.fromJson(json);
}

/// @nodoc
mixin _$Submission {
  String get problemId => throw _privateConstructorUsedError;
  int get memory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubmissionCopyWith<Submission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubmissionCopyWith<$Res> {
  factory $SubmissionCopyWith(
          Submission value, $Res Function(Submission) then) =
      _$SubmissionCopyWithImpl<$Res, Submission>;
  @useResult
  $Res call({String problemId, int memory});
}

/// @nodoc
class _$SubmissionCopyWithImpl<$Res, $Val extends Submission>
    implements $SubmissionCopyWith<$Res> {
  _$SubmissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problemId = null,
    Object? memory = null,
  }) {
    return _then(_value.copyWith(
      problemId: null == problemId
          ? _value.problemId
          : problemId // ignore: cast_nullable_to_non_nullable
              as String,
      memory: null == memory
          ? _value.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubmissionCopyWith<$Res>
    implements $SubmissionCopyWith<$Res> {
  factory _$$_SubmissionCopyWith(
          _$_Submission value, $Res Function(_$_Submission) then) =
      __$$_SubmissionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String problemId, int memory});
}

/// @nodoc
class __$$_SubmissionCopyWithImpl<$Res>
    extends _$SubmissionCopyWithImpl<$Res, _$_Submission>
    implements _$$_SubmissionCopyWith<$Res> {
  __$$_SubmissionCopyWithImpl(
      _$_Submission _value, $Res Function(_$_Submission) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? problemId = null,
    Object? memory = null,
  }) {
    return _then(_$_Submission(
      problemId: null == problemId
          ? _value.problemId
          : problemId // ignore: cast_nullable_to_non_nullable
              as String,
      memory: null == memory
          ? _value.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Submission implements _Submission {
  const _$_Submission({required this.problemId, required this.memory});

  factory _$_Submission.fromJson(Map<String, dynamic> json) =>
      _$$_SubmissionFromJson(json);

  @override
  final String problemId;
  @override
  final int memory;

  @override
  String toString() {
    return 'Submission(problemId: $problemId, memory: $memory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Submission &&
            (identical(other.problemId, problemId) ||
                other.problemId == problemId) &&
            (identical(other.memory, memory) || other.memory == memory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, problemId, memory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubmissionCopyWith<_$_Submission> get copyWith =>
      __$$_SubmissionCopyWithImpl<_$_Submission>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubmissionToJson(
      this,
    );
  }
}

abstract class _Submission implements Submission {
  const factory _Submission(
      {required final String problemId,
      required final int memory}) = _$_Submission;

  factory _Submission.fromJson(Map<String, dynamic> json) =
      _$_Submission.fromJson;

  @override
  String get problemId;
  @override
  int get memory;
  @override
  @JsonKey(ignore: true)
  _$$_SubmissionCopyWith<_$_Submission> get copyWith =>
      throw _privateConstructorUsedError;
}
