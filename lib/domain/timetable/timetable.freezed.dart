// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Timetable _$TimetableFromJson(Map<String, dynamic> json) {
  return _Timetable.fromJson(json);
}

/// @nodoc
mixin _$Timetable {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<Lecture>? get lectures => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimetableCopyWith<Timetable> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimetableCopyWith<$Res> {
  factory $TimetableCopyWith(Timetable value, $Res Function(Timetable) then) =
      _$TimetableCopyWithImpl<$Res, Timetable>;
  @useResult
  $Res call({int id, String name, List<Lecture>? lectures});
}

/// @nodoc
class _$TimetableCopyWithImpl<$Res, $Val extends Timetable>
    implements $TimetableCopyWith<$Res> {
  _$TimetableCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lectures = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lectures: freezed == lectures
          ? _value.lectures
          : lectures // ignore: cast_nullable_to_non_nullable
              as List<Lecture>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TimetableCopyWith<$Res> implements $TimetableCopyWith<$Res> {
  factory _$$_TimetableCopyWith(
          _$_Timetable value, $Res Function(_$_Timetable) then) =
      __$$_TimetableCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, List<Lecture>? lectures});
}

/// @nodoc
class __$$_TimetableCopyWithImpl<$Res>
    extends _$TimetableCopyWithImpl<$Res, _$_Timetable>
    implements _$$_TimetableCopyWith<$Res> {
  __$$_TimetableCopyWithImpl(
      _$_Timetable _value, $Res Function(_$_Timetable) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lectures = freezed,
  }) {
    return _then(_$_Timetable(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lectures: freezed == lectures
          ? _value._lectures
          : lectures // ignore: cast_nullable_to_non_nullable
              as List<Lecture>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Timetable implements _Timetable {
  const _$_Timetable(
      {required this.id, required this.name, final List<Lecture>? lectures})
      : _lectures = lectures;

  factory _$_Timetable.fromJson(Map<String, dynamic> json) =>
      _$$_TimetableFromJson(json);

  @override
  final int id;
  @override
  final String name;
  final List<Lecture>? _lectures;
  @override
  List<Lecture>? get lectures {
    final value = _lectures;
    if (value == null) return null;
    if (_lectures is EqualUnmodifiableListView) return _lectures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Timetable(id: $id, name: $name, lectures: $lectures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Timetable &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._lectures, _lectures));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_lectures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TimetableCopyWith<_$_Timetable> get copyWith =>
      __$$_TimetableCopyWithImpl<_$_Timetable>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TimetableToJson(
      this,
    );
  }
}

abstract class _Timetable implements Timetable {
  const factory _Timetable(
      {required final int id,
      required final String name,
      final List<Lecture>? lectures}) = _$_Timetable;

  factory _Timetable.fromJson(Map<String, dynamic> json) =
      _$_Timetable.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  List<Lecture>? get lectures;
  @override
  @JsonKey(ignore: true)
  _$$_TimetableCopyWith<_$_Timetable> get copyWith =>
      throw _privateConstructorUsedError;
}

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return _Lecture.fromJson(json);
}

/// @nodoc
mixin _$Lecture {
  String get name => throw _privateConstructorUsedError;
  String get memo => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get color => throw _privateConstructorUsedError;
  List<LectureTime> get times => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureCopyWith<Lecture> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureCopyWith<$Res> {
  factory $LectureCopyWith(Lecture value, $Res Function(Lecture) then) =
      _$LectureCopyWithImpl<$Res, Lecture>;
  @useResult
  $Res call(
      {String name,
      String memo,
      String type,
      String color,
      List<LectureTime> times});
}

/// @nodoc
class _$LectureCopyWithImpl<$Res, $Val extends Lecture>
    implements $LectureCopyWith<$Res> {
  _$LectureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? memo = null,
    Object? type = null,
    Object? color = null,
    Object? times = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<LectureTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LectureCopyWith<$Res> implements $LectureCopyWith<$Res> {
  factory _$$_LectureCopyWith(
          _$_Lecture value, $Res Function(_$_Lecture) then) =
      __$$_LectureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String memo,
      String type,
      String color,
      List<LectureTime> times});
}

/// @nodoc
class __$$_LectureCopyWithImpl<$Res>
    extends _$LectureCopyWithImpl<$Res, _$_Lecture>
    implements _$$_LectureCopyWith<$Res> {
  __$$_LectureCopyWithImpl(_$_Lecture _value, $Res Function(_$_Lecture) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? memo = null,
    Object? type = null,
    Object? color = null,
    Object? times = null,
  }) {
    return _then(_$_Lecture(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      memo: null == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      times: null == times
          ? _value._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<LectureTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Lecture implements _Lecture {
  const _$_Lecture(
      {required this.name,
      required this.memo,
      required this.type,
      required this.color,
      required final List<LectureTime> times})
      : _times = times;

  factory _$_Lecture.fromJson(Map<String, dynamic> json) =>
      _$$_LectureFromJson(json);

  @override
  final String name;
  @override
  final String memo;
  @override
  final String type;
  @override
  final String color;
  final List<LectureTime> _times;
  @override
  List<LectureTime> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

  @override
  String toString() {
    return 'Lecture(name: $name, memo: $memo, type: $type, color: $color, times: $times)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Lecture &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.memo, memo) || other.memo == memo) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality().equals(other._times, _times));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, memo, type, color,
      const DeepCollectionEquality().hash(_times));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LectureCopyWith<_$_Lecture> get copyWith =>
      __$$_LectureCopyWithImpl<_$_Lecture>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureToJson(
      this,
    );
  }
}

abstract class _Lecture implements Lecture {
  const factory _Lecture(
      {required final String name,
      required final String memo,
      required final String type,
      required final String color,
      required final List<LectureTime> times}) = _$_Lecture;

  factory _Lecture.fromJson(Map<String, dynamic> json) = _$_Lecture.fromJson;

  @override
  String get name;
  @override
  String get memo;
  @override
  String get type;
  @override
  String get color;
  @override
  List<LectureTime> get times;
  @override
  @JsonKey(ignore: true)
  _$$_LectureCopyWith<_$_Lecture> get copyWith =>
      throw _privateConstructorUsedError;
}

LectureTime _$LectureTimeFromJson(Map<String, dynamic> json) {
  return _LectureTime.fromJson(json);
}

/// @nodoc
mixin _$LectureTime {
  String get start => throw _privateConstructorUsedError;
  String get end => throw _privateConstructorUsedError;
  String get week => throw _privateConstructorUsedError;
  String get place => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureTimeCopyWith<LectureTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureTimeCopyWith<$Res> {
  factory $LectureTimeCopyWith(
          LectureTime value, $Res Function(LectureTime) then) =
      _$LectureTimeCopyWithImpl<$Res, LectureTime>;
  @useResult
  $Res call({String start, String end, String week, String place});
}

/// @nodoc
class _$LectureTimeCopyWithImpl<$Res, $Val extends LectureTime>
    implements $LectureTimeCopyWith<$Res> {
  _$LectureTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? week = null,
    Object? place = null,
  }) {
    return _then(_value.copyWith(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as String,
      place: null == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LectureTimeCopyWith<$Res>
    implements $LectureTimeCopyWith<$Res> {
  factory _$$_LectureTimeCopyWith(
          _$_LectureTime value, $Res Function(_$_LectureTime) then) =
      __$$_LectureTimeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end, String week, String place});
}

/// @nodoc
class __$$_LectureTimeCopyWithImpl<$Res>
    extends _$LectureTimeCopyWithImpl<$Res, _$_LectureTime>
    implements _$$_LectureTimeCopyWith<$Res> {
  __$$_LectureTimeCopyWithImpl(
      _$_LectureTime _value, $Res Function(_$_LectureTime) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? week = null,
    Object? place = null,
  }) {
    return _then(_$_LectureTime(
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as String,
      end: null == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as String,
      week: null == week
          ? _value.week
          : week // ignore: cast_nullable_to_non_nullable
              as String,
      place: null == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LectureTime implements _LectureTime {
  const _$_LectureTime(
      {required this.start,
      required this.end,
      required this.week,
      required this.place});

  factory _$_LectureTime.fromJson(Map<String, dynamic> json) =>
      _$$_LectureTimeFromJson(json);

  @override
  final String start;
  @override
  final String end;
  @override
  final String week;
  @override
  final String place;

  @override
  String toString() {
    return 'LectureTime(start: $start, end: $end, week: $week, place: $place)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LectureTime &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.week, week) || other.week == week) &&
            (identical(other.place, place) || other.place == place));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, start, end, week, place);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LectureTimeCopyWith<_$_LectureTime> get copyWith =>
      __$$_LectureTimeCopyWithImpl<_$_LectureTime>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureTimeToJson(
      this,
    );
  }
}

abstract class _LectureTime implements LectureTime {
  const factory _LectureTime(
      {required final String start,
      required final String end,
      required final String week,
      required final String place}) = _$_LectureTime;

  factory _LectureTime.fromJson(Map<String, dynamic> json) =
      _$_LectureTime.fromJson;

  @override
  String get start;
  @override
  String get end;
  @override
  String get week;
  @override
  String get place;
  @override
  @JsonKey(ignore: true)
  _$$_LectureTimeCopyWith<_$_LectureTime> get copyWith =>
      throw _privateConstructorUsedError;
}
