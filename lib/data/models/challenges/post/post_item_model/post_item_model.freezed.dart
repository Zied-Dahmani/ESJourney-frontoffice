// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostItem _$PostItemFromJson(Map<String, dynamic> json) {
  return _PostItem.fromJson(json);
}

/// @nodoc
mixin _$PostItem {
  String get status => throw _privateConstructorUsedError;
  String? get mediaContent => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostItemCopyWith<PostItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostItemCopyWith<$Res> {
  factory $PostItemCopyWith(PostItem value, $Res Function(PostItem) then) =
      _$PostItemCopyWithImpl<$Res, PostItem>;
  @useResult
  $Res call({String status, String? mediaContent, int createdAt});
}

/// @nodoc
class _$PostItemCopyWithImpl<$Res, $Val extends PostItem>
    implements $PostItemCopyWith<$Res> {
  _$PostItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? mediaContent = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      mediaContent: freezed == mediaContent
          ? _value.mediaContent
          : mediaContent // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostItemCopyWith<$Res> implements $PostItemCopyWith<$Res> {
  factory _$$_PostItemCopyWith(
          _$_PostItem value, $Res Function(_$_PostItem) then) =
      __$$_PostItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, String? mediaContent, int createdAt});
}

/// @nodoc
class __$$_PostItemCopyWithImpl<$Res>
    extends _$PostItemCopyWithImpl<$Res, _$_PostItem>
    implements _$$_PostItemCopyWith<$Res> {
  __$$_PostItemCopyWithImpl(
      _$_PostItem _value, $Res Function(_$_PostItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? mediaContent = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$_PostItem(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      mediaContent: freezed == mediaContent
          ? _value.mediaContent
          : mediaContent // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostItem implements _PostItem {
  const _$_PostItem(
      {required this.status, this.mediaContent, required this.createdAt});

  factory _$_PostItem.fromJson(Map<String, dynamic> json) =>
      _$$_PostItemFromJson(json);

  @override
  final String status;
  @override
  final String? mediaContent;
  @override
  final int createdAt;

  @override
  String toString() {
    return 'PostItem(status: $status, mediaContent: $mediaContent, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostItem &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.mediaContent, mediaContent) ||
                other.mediaContent == mediaContent) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, mediaContent, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostItemCopyWith<_$_PostItem> get copyWith =>
      __$$_PostItemCopyWithImpl<_$_PostItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostItemToJson(
      this,
    );
  }
}

abstract class _PostItem implements PostItem {
  const factory _PostItem(
      {required final String status,
      final String? mediaContent,
      required final int createdAt}) = _$_PostItem;

  factory _PostItem.fromJson(Map<String, dynamic> json) = _$_PostItem.fromJson;

  @override
  String get status;
  @override
  String? get mediaContent;
  @override
  int get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_PostItemCopyWith<_$_PostItem> get copyWith =>
      throw _privateConstructorUsedError;
}
