// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'club_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Club _$ClubFromJson(Map<String, dynamic> json) {
  return _Club.fromJson(json);
}

/// @nodoc
mixin _$Club {
  dynamic get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get images => throw _privateConstructorUsedError;
  String get shortDescription => throw _privateConstructorUsedError;
  String get fullDescription => throw _privateConstructorUsedError;
  List<dynamic> get likes => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  List<String> get shorts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClubCopyWith<Club> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClubCopyWith<$Res> {
  factory $ClubCopyWith(Club value, $Res Function(Club) then) =
      _$ClubCopyWithImpl<$Res, Club>;
  @useResult
  $Res call(
      {dynamic id,
      String name,
      List<String> images,
      String shortDescription,
      String fullDescription,
      List<dynamic> likes,
      DateTime deadline,
      List<String> shorts});
}

/// @nodoc
class _$ClubCopyWithImpl<$Res, $Val extends Club>
    implements $ClubCopyWith<$Res> {
  _$ClubCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? images = null,
    Object? shortDescription = null,
    Object? fullDescription = null,
    Object? likes = null,
    Object? deadline = null,
    Object? shorts = null,
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
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      fullDescription: null == fullDescription
          ? _value.fullDescription
          : fullDescription // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shorts: null == shorts
          ? _value.shorts
          : shorts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClubCopyWith<$Res> implements $ClubCopyWith<$Res> {
  factory _$$_ClubCopyWith(_$_Club value, $Res Function(_$_Club) then) =
      __$$_ClubCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      String name,
      List<String> images,
      String shortDescription,
      String fullDescription,
      List<dynamic> likes,
      DateTime deadline,
      List<String> shorts});
}

/// @nodoc
class __$$_ClubCopyWithImpl<$Res> extends _$ClubCopyWithImpl<$Res, _$_Club>
    implements _$$_ClubCopyWith<$Res> {
  __$$_ClubCopyWithImpl(_$_Club _value, $Res Function(_$_Club) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? images = null,
    Object? shortDescription = null,
    Object? fullDescription = null,
    Object? likes = null,
    Object? deadline = null,
    Object? shorts = null,
  }) {
    return _then(_$_Club(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      images: null == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      shortDescription: null == shortDescription
          ? _value.shortDescription
          : shortDescription // ignore: cast_nullable_to_non_nullable
              as String,
      fullDescription: null == fullDescription
          ? _value.fullDescription
          : fullDescription // ignore: cast_nullable_to_non_nullable
              as String,
      likes: null == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      shorts: null == shorts
          ? _value._shorts
          : shorts // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Club extends _Club {
  const _$_Club(
      {required this.id,
      required this.name,
      required final List<String> images,
      required this.shortDescription,
      required this.fullDescription,
      required final List<dynamic> likes,
      required this.deadline,
      required final List<String> shorts})
      : _images = images,
        _likes = likes,
        _shorts = shorts,
        super._();

  factory _$_Club.fromJson(Map<String, dynamic> json) => _$$_ClubFromJson(json);

  @override
  final dynamic id;
  @override
  final String name;
  final List<String> _images;
  @override
  List<String> get images {
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_images);
  }

  @override
  final String shortDescription;
  @override
  final String fullDescription;
  final List<dynamic> _likes;
  @override
  List<dynamic> get likes {
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likes);
  }

  @override
  final DateTime deadline;
  final List<String> _shorts;
  @override
  List<String> get shorts {
    if (_shorts is EqualUnmodifiableListView) return _shorts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_shorts);
  }

  @override
  String toString() {
    return 'Club(id: $id, name: $name, images: $images, shortDescription: $shortDescription, fullDescription: $fullDescription, likes: $likes, deadline: $deadline, shorts: $shorts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Club &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.shortDescription, shortDescription) ||
                other.shortDescription == shortDescription) &&
            (identical(other.fullDescription, fullDescription) ||
                other.fullDescription == fullDescription) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            const DeepCollectionEquality().equals(other._shorts, _shorts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      name,
      const DeepCollectionEquality().hash(_images),
      shortDescription,
      fullDescription,
      const DeepCollectionEquality().hash(_likes),
      deadline,
      const DeepCollectionEquality().hash(_shorts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClubCopyWith<_$_Club> get copyWith =>
      __$$_ClubCopyWithImpl<_$_Club>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClubToJson(
      this,
    );
  }
}

abstract class _Club extends Club {
  const factory _Club(
      {required final dynamic id,
      required final String name,
      required final List<String> images,
      required final String shortDescription,
      required final String fullDescription,
      required final List<dynamic> likes,
      required final DateTime deadline,
      required final List<String> shorts}) = _$_Club;
  const _Club._() : super._();

  factory _Club.fromJson(Map<String, dynamic> json) = _$_Club.fromJson;

  @override
  dynamic get id;
  @override
  String get name;
  @override
  List<String> get images;
  @override
  String get shortDescription;
  @override
  String get fullDescription;
  @override
  List<dynamic> get likes;
  @override
  DateTime get deadline;
  @override
  List<String> get shorts;
  @override
  @JsonKey(ignore: true)
  _$$_ClubCopyWith<_$_Club> get copyWith => throw _privateConstructorUsedError;
}
