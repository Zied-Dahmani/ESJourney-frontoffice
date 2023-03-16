// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  dynamic get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  int get coins => throw _privateConstructorUsedError;
  String get lastSeen => throw _privateConstructorUsedError;
  String? get twoDAvatar => throw _privateConstructorUsedError;
  String? get threeDAvatar => throw _privateConstructorUsedError;
  List<UserCourse>? get courses => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {dynamic id,
      String username,
      String email,
      String password,
      int grade,
      int coins,
      String lastSeen,
      String? twoDAvatar,
      String? threeDAvatar,
      List<UserCourse>? courses,
      bool online,
      String? token,
      String fullName});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? grade = null,
    Object? coins = null,
    Object? lastSeen = null,
    Object? twoDAvatar = freezed,
    Object? threeDAvatar = freezed,
    Object? courses = freezed,
    Object? online = null,
    Object? token = freezed,
    Object? fullName = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as String,
      twoDAvatar: freezed == twoDAvatar
          ? _value.twoDAvatar
          : twoDAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      threeDAvatar: freezed == threeDAvatar
          ? _value.threeDAvatar
          : threeDAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      courses: freezed == courses
          ? _value.courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<UserCourse>?,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic id,
      String username,
      String email,
      String password,
      int grade,
      int coins,
      String lastSeen,
      String? twoDAvatar,
      String? threeDAvatar,
      List<UserCourse>? courses,
      bool online,
      String? token,
      String fullName});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? grade = null,
    Object? coins = null,
    Object? lastSeen = null,
    Object? twoDAvatar = freezed,
    Object? threeDAvatar = freezed,
    Object? courses = freezed,
    Object? online = null,
    Object? token = freezed,
    Object? fullName = null,
  }) {
    return _then(_$_User(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as dynamic,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      grade: null == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as int,
      lastSeen: null == lastSeen
          ? _value.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as String,
      twoDAvatar: freezed == twoDAvatar
          ? _value.twoDAvatar
          : twoDAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      threeDAvatar: freezed == threeDAvatar
          ? _value.threeDAvatar
          : threeDAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      courses: freezed == courses
          ? _value._courses
          : courses // ignore: cast_nullable_to_non_nullable
              as List<UserCourse>?,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      fullName: null == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_User implements _User {
  const _$_User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.grade,
      required this.coins,
      required this.lastSeen,
      this.twoDAvatar,
      this.threeDAvatar,
      final List<UserCourse>? courses,
      required this.online,
      this.token,
      required this.fullName})
      : _courses = courses;

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final dynamic id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String password;
  @override
  final int grade;
  @override
  final int coins;
  @override
  final String lastSeen;
  @override
  final String? twoDAvatar;
  @override
  final String? threeDAvatar;
  final List<UserCourse>? _courses;
  @override
  List<UserCourse>? get courses {
    final value = _courses;
    if (value == null) return null;
    if (_courses is EqualUnmodifiableListView) return _courses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool online;
  @override
  final String? token;
  @override
  final String fullName;

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, password: $password, grade: $grade, coins: $coins, lastSeen: $lastSeen, twoDAvatar: $twoDAvatar, threeDAvatar: $threeDAvatar, courses: $courses, online: $online, token: $token, fullName: $fullName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            const DeepCollectionEquality().equals(other.id, id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.coins, coins) || other.coins == coins) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.twoDAvatar, twoDAvatar) ||
                other.twoDAvatar == twoDAvatar) &&
            (identical(other.threeDAvatar, threeDAvatar) ||
                other.threeDAvatar == threeDAvatar) &&
            const DeepCollectionEquality().equals(other._courses, _courses) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      username,
      email,
      password,
      grade,
      coins,
      lastSeen,
      twoDAvatar,
      threeDAvatar,
      const DeepCollectionEquality().hash(_courses),
      online,
      token,
      fullName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final dynamic id,
      required final String username,
      required final String email,
      required final String password,
      required final int grade,
      required final int coins,
      required final String lastSeen,
      final String? twoDAvatar,
      final String? threeDAvatar,
      final List<UserCourse>? courses,
      required final bool online,
      final String? token,
      required final String fullName}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  dynamic get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get password;
  @override
  int get grade;
  @override
  int get coins;
  @override
  String get lastSeen;
  @override
  String? get twoDAvatar;
  @override
  String? get threeDAvatar;
  @override
  List<UserCourse>? get courses;
  @override
  bool get online;
  @override
  String? get token;
  @override
  String get fullName;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
