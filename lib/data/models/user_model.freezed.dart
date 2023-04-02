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
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  int get grade => throw _privateConstructorUsedError;
  List<Event>? get events => throw _privateConstructorUsedError;
  double get coins => throw _privateConstructorUsedError;
  String get lastSeen => throw _privateConstructorUsedError;
  String? get twoDAvatar => throw _privateConstructorUsedError;
  String? get threeDAvatar => throw _privateConstructorUsedError;
  List<UserCourse>? get courses => throw _privateConstructorUsedError;
  bool get online => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get fullName => throw _privateConstructorUsedError;
  String? get walletAddress => throw _privateConstructorUsedError;
  String? get privateKey => throw _privateConstructorUsedError;
  Score? get score => throw _privateConstructorUsedError;
  Achievement? get achievement => throw _privateConstructorUsedError;
  List<Achievement>? get achievements => throw _privateConstructorUsedError;

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
      {String id,
      String username,
      String email,
      String password,
      int grade,
      List<Event>? events,
      double coins,
      String lastSeen,
      String? twoDAvatar,
      String? threeDAvatar,
      List<UserCourse>? courses,
      bool online,
      String? token,
      String? fullName,
      String? walletAddress,
      String? privateKey,
      Score? score,
      Achievement? achievement,
      List<Achievement>? achievements});

  $ScoreCopyWith<$Res>? get score;
  $AchievementCopyWith<$Res>? get achievement;
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
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? grade = null,
    Object? events = freezed,
    Object? coins = null,
    Object? lastSeen = null,
    Object? twoDAvatar = freezed,
    Object? threeDAvatar = freezed,
    Object? courses = freezed,
    Object? online = null,
    Object? token = freezed,
    Object? fullName = freezed,
    Object? walletAddress = freezed,
    Object? privateKey = freezed,
    Object? score = freezed,
    Object? achievement = freezed,
    Object? achievements = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      events: freezed == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>?,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as double,
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
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      walletAddress: freezed == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      privateKey: freezed == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score?,
      achievement: freezed == achievement
          ? _value.achievement
          : achievement // ignore: cast_nullable_to_non_nullable
              as Achievement?,
      achievements: freezed == achievements
          ? _value.achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<Achievement>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScoreCopyWith<$Res>? get score {
    if (_value.score == null) {
      return null;
    }

    return $ScoreCopyWith<$Res>(_value.score!, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $AchievementCopyWith<$Res>? get achievement {
    if (_value.achievement == null) {
      return null;
    }

    return $AchievementCopyWith<$Res>(_value.achievement!, (value) {
      return _then(_value.copyWith(achievement: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String email,
      String password,
      int grade,
      List<Event>? events,
      double coins,
      String lastSeen,
      String? twoDAvatar,
      String? threeDAvatar,
      List<UserCourse>? courses,
      bool online,
      String? token,
      String? fullName,
      String? walletAddress,
      String? privateKey,
      Score? score,
      Achievement? achievement,
      List<Achievement>? achievements});

  @override
  $ScoreCopyWith<$Res>? get score;
  @override
  $AchievementCopyWith<$Res>? get achievement;
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? email = null,
    Object? password = null,
    Object? grade = null,
    Object? events = freezed,
    Object? coins = null,
    Object? lastSeen = null,
    Object? twoDAvatar = freezed,
    Object? threeDAvatar = freezed,
    Object? courses = freezed,
    Object? online = null,
    Object? token = freezed,
    Object? fullName = freezed,
    Object? walletAddress = freezed,
    Object? privateKey = freezed,
    Object? score = freezed,
    Object? achievement = freezed,
    Object? achievements = freezed,
  }) {
    return _then(_$_User(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
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
      events: freezed == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>?,
      coins: null == coins
          ? _value.coins
          : coins // ignore: cast_nullable_to_non_nullable
              as double,
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
      fullName: freezed == fullName
          ? _value.fullName
          : fullName // ignore: cast_nullable_to_non_nullable
              as String?,
      walletAddress: freezed == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      privateKey: freezed == privateKey
          ? _value.privateKey
          : privateKey // ignore: cast_nullable_to_non_nullable
              as String?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as Score?,
      achievement: freezed == achievement
          ? _value.achievement
          : achievement // ignore: cast_nullable_to_non_nullable
              as Achievement?,
      achievements: freezed == achievements
          ? _value._achievements
          : achievements // ignore: cast_nullable_to_non_nullable
              as List<Achievement>?,
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
      final List<Event>? events,
      required this.coins,
      required this.lastSeen,
      this.twoDAvatar,
      this.threeDAvatar,
      final List<UserCourse>? courses,
      required this.online,
      this.token,
      this.fullName,
      this.walletAddress,
      this.privateKey,
      this.score,
      this.achievement,
      final List<Achievement>? achievements})
      : _events = events,
        _courses = courses,
        _achievements = achievements;

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String email;
  @override
  final String password;
  @override
  final int grade;
  final List<Event>? _events;
  @override
  List<Event>? get events {
    final value = _events;
    if (value == null) return null;
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double coins;
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
  final String? fullName;
  @override
  final String? walletAddress;
  @override
  final String? privateKey;
  @override
  final Score? score;
  @override
  final Achievement? achievement;
  final List<Achievement>? _achievements;
  @override
  List<Achievement>? get achievements {
    final value = _achievements;
    if (value == null) return null;
    if (_achievements is EqualUnmodifiableListView) return _achievements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'User(id: $id, username: $username, email: $email, password: $password, grade: $grade, events: $events, coins: $coins, lastSeen: $lastSeen, twoDAvatar: $twoDAvatar, threeDAvatar: $threeDAvatar, courses: $courses, online: $online, token: $token, fullName: $fullName, walletAddress: $walletAddress, privateKey: $privateKey, score: $score, achievement: $achievement, achievements: $achievements)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            const DeepCollectionEquality().equals(other._events, _events) &&
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
                other.fullName == fullName) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.privateKey, privateKey) ||
                other.privateKey == privateKey) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.achievement, achievement) ||
                other.achievement == achievement) &&
            const DeepCollectionEquality()
                .equals(other._achievements, _achievements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        username,
        email,
        password,
        grade,
        const DeepCollectionEquality().hash(_events),
        coins,
        lastSeen,
        twoDAvatar,
        threeDAvatar,
        const DeepCollectionEquality().hash(_courses),
        online,
        token,
        fullName,
        walletAddress,
        privateKey,
        score,
        achievement,
        const DeepCollectionEquality().hash(_achievements)
      ]);

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
      {required final String id,
      required final String username,
      required final String email,
      required final String password,
      required final int grade,
      final List<Event>? events,
      required final double coins,
      required final String lastSeen,
      final String? twoDAvatar,
      final String? threeDAvatar,
      final List<UserCourse>? courses,
      required final bool online,
      final String? token,
      final String? fullName,
      final String? walletAddress,
      final String? privateKey,
      final Score? score,
      final Achievement? achievement,
      final List<Achievement>? achievements}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String get email;
  @override
  String get password;
  @override
  int get grade;
  @override
  List<Event>? get events;
  @override
  double get coins;
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
  String? get fullName;
  @override
  String? get walletAddress;
  @override
  String? get privateKey;
  @override
  Score? get score;
  @override
  Achievement? get achievement;
  @override
  List<Achievement>? get achievements;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
