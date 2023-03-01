// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'top_solutions_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TopSolutions _$TopSolutionsFromJson(Map<String, dynamic> json) {
  return _TopSolutions.fromJson(json);
}

/// @nodoc
mixin _$TopSolutions {
  String get memory => throw _privateConstructorUsedError;
  String get percentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TopSolutionsCopyWith<TopSolutions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopSolutionsCopyWith<$Res> {
  factory $TopSolutionsCopyWith(
          TopSolutions value, $Res Function(TopSolutions) then) =
      _$TopSolutionsCopyWithImpl<$Res, TopSolutions>;
  @useResult
  $Res call({String memory, String percentage});
}

/// @nodoc
class _$TopSolutionsCopyWithImpl<$Res, $Val extends TopSolutions>
    implements $TopSolutionsCopyWith<$Res> {
  _$TopSolutionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memory = null,
    Object? percentage = null,
  }) {
    return _then(_value.copyWith(
      memory: null == memory
          ? _value.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TopSolutionsCopyWith<$Res>
    implements $TopSolutionsCopyWith<$Res> {
  factory _$$_TopSolutionsCopyWith(
          _$_TopSolutions value, $Res Function(_$_TopSolutions) then) =
      __$$_TopSolutionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String memory, String percentage});
}

/// @nodoc
class __$$_TopSolutionsCopyWithImpl<$Res>
    extends _$TopSolutionsCopyWithImpl<$Res, _$_TopSolutions>
    implements _$$_TopSolutionsCopyWith<$Res> {
  __$$_TopSolutionsCopyWithImpl(
      _$_TopSolutions _value, $Res Function(_$_TopSolutions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? memory = null,
    Object? percentage = null,
  }) {
    return _then(_$_TopSolutions(
      memory: null == memory
          ? _value.memory
          : memory // ignore: cast_nullable_to_non_nullable
              as String,
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TopSolutions implements _TopSolutions {
  const _$_TopSolutions({required this.memory, required this.percentage});

  factory _$_TopSolutions.fromJson(Map<String, dynamic> json) =>
      _$$_TopSolutionsFromJson(json);

  @override
  final String memory;
  @override
  final String percentage;

  @override
  String toString() {
    return 'TopSolutions(memory: $memory, percentage: $percentage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TopSolutions &&
            (identical(other.memory, memory) || other.memory == memory) &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, memory, percentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TopSolutionsCopyWith<_$_TopSolutions> get copyWith =>
      __$$_TopSolutionsCopyWithImpl<_$_TopSolutions>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TopSolutionsToJson(
      this,
    );
  }
}

abstract class _TopSolutions implements TopSolutions {
  const factory _TopSolutions(
      {required final String memory,
      required final String percentage}) = _$_TopSolutions;

  factory _TopSolutions.fromJson(Map<String, dynamic> json) =
      _$_TopSolutions.fromJson;

  @override
  String get memory;
  @override
  String get percentage;
  @override
  @JsonKey(ignore: true)
  _$$_TopSolutionsCopyWith<_$_TopSolutions> get copyWith =>
      throw _privateConstructorUsedError;
}
