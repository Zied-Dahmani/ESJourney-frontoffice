// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get eventImage => throw _privateConstructorUsedError;
  String get location => throw _privateConstructorUsedError;
  String get requirementsDescription => throw _privateConstructorUsedError;
  MeetingDetail? get meeting => throw _privateConstructorUsedError;
  List<Poll>? get polls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      String startTime,
      String endTime,
      String description,
      bool isDone,
      String type,
      String eventImage,
      String location,
      String requirementsDescription,
      MeetingDetail? meeting,
      List<Poll>? polls});

  $MeetingDetailCopyWith<$Res>? get meeting;
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? description = null,
    Object? isDone = null,
    Object? type = null,
    Object? eventImage = null,
    Object? location = null,
    Object? requirementsDescription = null,
    Object? meeting = freezed,
    Object? polls = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      eventImage: null == eventImage
          ? _value.eventImage
          : eventImage // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      requirementsDescription: null == requirementsDescription
          ? _value.requirementsDescription
          : requirementsDescription // ignore: cast_nullable_to_non_nullable
              as String,
      meeting: freezed == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingDetail?,
      polls: freezed == polls
          ? _value.polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<Poll>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MeetingDetailCopyWith<$Res>? get meeting {
    if (_value.meeting == null) {
      return null;
    }

    return $MeetingDetailCopyWith<$Res>(_value.meeting!, (value) {
      return _then(_value.copyWith(meeting: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      DateTime date,
      String startTime,
      String endTime,
      String description,
      bool isDone,
      String type,
      String eventImage,
      String location,
      String requirementsDescription,
      MeetingDetail? meeting,
      List<Poll>? polls});

  @override
  $MeetingDetailCopyWith<$Res>? get meeting;
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res, _$_Event>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? description = null,
    Object? isDone = null,
    Object? type = null,
    Object? eventImage = null,
    Object? location = null,
    Object? requirementsDescription = null,
    Object? meeting = freezed,
    Object? polls = freezed,
  }) {
    return _then(_$_Event(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: null == isDone
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      eventImage: null == eventImage
          ? _value.eventImage
          : eventImage // ignore: cast_nullable_to_non_nullable
              as String,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      requirementsDescription: null == requirementsDescription
          ? _value.requirementsDescription
          : requirementsDescription // ignore: cast_nullable_to_non_nullable
              as String,
      meeting: freezed == meeting
          ? _value.meeting
          : meeting // ignore: cast_nullable_to_non_nullable
              as MeetingDetail?,
      polls: freezed == polls
          ? _value._polls
          : polls // ignore: cast_nullable_to_non_nullable
              as List<Poll>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event implements _Event {
  const _$_Event(
      {required this.id,
      required this.title,
      required this.date,
      required this.startTime,
      required this.endTime,
      required this.description,
      required this.isDone,
      required this.type,
      required this.eventImage,
      required this.location,
      required this.requirementsDescription,
      this.meeting,
      final List<Poll>? polls})
      : _polls = polls;

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String description;
  @override
  final bool isDone;
  @override
  final String type;
  @override
  final String eventImage;
  @override
  final String location;
  @override
  final String requirementsDescription;
  @override
  final MeetingDetail? meeting;
  final List<Poll>? _polls;
  @override
  List<Poll>? get polls {
    final value = _polls;
    if (value == null) return null;
    if (_polls is EqualUnmodifiableListView) return _polls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Event(id: $id, title: $title, date: $date, startTime: $startTime, endTime: $endTime, description: $description, isDone: $isDone, type: $type, eventImage: $eventImage, location: $location, requirementsDescription: $requirementsDescription, meeting: $meeting, polls: $polls)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isDone, isDone) || other.isDone == isDone) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.eventImage, eventImage) ||
                other.eventImage == eventImage) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(
                    other.requirementsDescription, requirementsDescription) ||
                other.requirementsDescription == requirementsDescription) &&
            (identical(other.meeting, meeting) || other.meeting == meeting) &&
            const DeepCollectionEquality().equals(other._polls, _polls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      date,
      startTime,
      endTime,
      description,
      isDone,
      type,
      eventImage,
      location,
      requirementsDescription,
      meeting,
      const DeepCollectionEquality().hash(_polls));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String id,
      required final String title,
      required final DateTime date,
      required final String startTime,
      required final String endTime,
      required final String description,
      required final bool isDone,
      required final String type,
      required final String eventImage,
      required final String location,
      required final String requirementsDescription,
      final MeetingDetail? meeting,
      final List<Poll>? polls}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get description;
  @override
  bool get isDone;
  @override
  String get type;
  @override
  String get eventImage;
  @override
  String get location;
  @override
  String get requirementsDescription;
  @override
  MeetingDetail? get meeting;
  @override
  List<Poll>? get polls;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}
