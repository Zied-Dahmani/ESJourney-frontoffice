// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coding_problem_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CodingProblem _$CodingProblemFromJson(Map<String, dynamic> json) {
  return _CodingProblem.fromJson(json);
}

/// @nodoc
mixin _$CodingProblem {
  dynamic get id => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get output => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CodingProblemCopyWith<CodingProblem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CodingProblemCopyWith<$Res> {
  factory $CodingProblemCopyWith(
          CodingProblem value, $Res Function(CodingProblem) then) =
      _$CodingProblemCopyWithImpl<$Res, CodingProblem>;
  @useResult
  $Res call({dynamic id, String description, String output});
}

/// @nodoc
class _$CodingProblemCopyWithImpl<$Res, $Val extends CodingProblem>
    implements $CodingProblemCopyWith<$Res> {
  _$CodingProblemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = null,
    Object? output = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CodingProblemCopyWith<$Res>
    implements $CodingProblemCopyWith<$Res> {
  factory _$$_CodingProblemCopyWith(
          _$_CodingProblem value, $Res Function(_$_CodingProblem) then) =
      __$$_CodingProblemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({dynamic id, String description, String output});
}

/// @nodoc
class __$$_CodingProblemCopyWithImpl<$Res>
    extends _$CodingProblemCopyWithImpl<$Res, _$_CodingProblem>
    implements _$$_CodingProblemCopyWith<$Res> {
  __$$_CodingProblemCopyWithImpl(
      _$_CodingProblem _value, $Res Function(_$_CodingProblem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = null,
    Object? output = null,
  }) {
    return _then(_$_CodingProblem(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      output: null == output
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CodingProblem implements _CodingProblem {
  const _$_CodingProblem(
      {required this.id, required this.description, required this.output});

  factory _$_CodingProblem.fromJson(Map<String, dynamic> json) =>
      _$$_CodingProblemFromJson(json);

  @override
  final dynamic id;
  @override
  final String description;
  @override
  final String output;

  @override
  String toString() {
    return 'CodingProblem(id: $id, description: $description, output: $output)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CodingProblem &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.output, output) || other.output == output));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(id), description, output);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CodingProblemCopyWith<_$_CodingProblem> get copyWith =>
      __$$_CodingProblemCopyWithImpl<_$_CodingProblem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CodingProblemToJson(
      this,
    );
  }
}

abstract class _CodingProblem implements CodingProblem {
  const factory _CodingProblem(
      {required final dynamic id,
      required final String description,
      required final String output}) = _$_CodingProblem;

  factory _CodingProblem.fromJson(Map<String, dynamic> json) =
      _$_CodingProblem.fromJson;

  @override
  dynamic get id;
  @override
  String get description;
  @override
  String get output;
  @override
  @JsonKey(ignore: true)
  _$$_CodingProblemCopyWith<_$_CodingProblem> get copyWith =>
      throw _privateConstructorUsedError;
}
