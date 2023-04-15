// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserCourse _$UserCourseFromJson(Map<String, dynamic> json) {
  return _UserCourse.fromJson(json);
}

/// @nodoc
mixin _$UserCourse {
  dynamic get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  List<String> get words => throw _privateConstructorUsedError;
  List<String> get definitions => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCourseCopyWith<UserCourse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCourseCopyWith<$Res> {
  factory $UserCourseCopyWith(
          UserCourse value, $Res Function(UserCourse) then) =
      _$UserCourseCopyWithImpl<$Res, UserCourse>;
  @useResult
  $Res call(
      {dynamic id,
      String courseId,
      List<String> words,
      List<String> definitions});
}

/// @nodoc
class _$UserCourseCopyWithImpl<$Res, $Val extends UserCourse>
    implements $UserCourseCopyWith<$Res> {
  _$UserCourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? courseId = null,
    Object? words = null,
    Object? definitions = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      words: null == words
          ? _value.words
          : words // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definitions: null == definitions
          ? _value.definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCourseCopyWith<$Res>
    implements $UserCourseCopyWith<$Res> {
  factory _$$_UserCourseCopyWith(
          _$_UserCourse value, $Res Function(_$_UserCourse) then) =
      __$$_UserCourseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      String courseId,
      List<String> words,
      List<String> definitions});
}

/// @nodoc
class __$$_UserCourseCopyWithImpl<$Res>
    extends _$UserCourseCopyWithImpl<$Res, _$_UserCourse>
    implements _$$_UserCourseCopyWith<$Res> {
  __$$_UserCourseCopyWithImpl(
      _$_UserCourse _value, $Res Function(_$_UserCourse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? courseId = null,
    Object? words = null,
    Object? definitions = null,
  }) {
    return _then(_$_UserCourse(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      words: null == words
          ? _value._words
          : words // ignore: cast_nullable_to_non_nullable
              as List<String>,
      definitions: null == definitions
          ? _value._definitions
          : definitions // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserCourse implements _UserCourse {
  const _$_UserCourse(
      {required this.id,
      required this.courseId,
      required final List<String> words,
      required final List<String> definitions})
      : _words = words,
        _definitions = definitions;

  factory _$_UserCourse.fromJson(Map<String, dynamic> json) =>
      _$$_UserCourseFromJson(json);

  @override
  final dynamic id;
  @override
  final String courseId;
  final List<String> _words;
  @override
  List<String> get words {
    if (_words is EqualUnmodifiableListView) return _words;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_words);
  }

  final List<String> _definitions;
  @override
  List<String> get definitions {
    if (_definitions is EqualUnmodifiableListView) return _definitions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_definitions);
  }

  @override
  String toString() {
    return 'UserCourse(id: $id, courseId: $courseId, words: $words, definitions: $definitions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserCourse &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            const DeepCollectionEquality().equals(other._words, _words) &&
            const DeepCollectionEquality()
                .equals(other._definitions, _definitions));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      courseId,
      const DeepCollectionEquality().hash(_words),
      const DeepCollectionEquality().hash(_definitions));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCourseCopyWith<_$_UserCourse> get copyWith =>
      __$$_UserCourseCopyWithImpl<_$_UserCourse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserCourseToJson(
      this,
    );
  }
}

abstract class _UserCourse implements UserCourse {
  const factory _UserCourse(
      {required final dynamic id,
      required final String courseId,
      required final List<String> words,
      required final List<String> definitions}) = _$_UserCourse;

  factory _UserCourse.fromJson(Map<String, dynamic> json) =
      _$_UserCourse.fromJson;

  @override
  dynamic get id;
  @override
  String get courseId;
  @override
  List<String> get words;
  @override
  List<String> get definitions;
  @override
  @JsonKey(ignore: true)
  _$$_UserCourseCopyWith<_$_UserCourse> get copyWith =>
      throw _privateConstructorUsedError;
}
