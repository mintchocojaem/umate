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
abstract class _$$TimetableImplCopyWith<$Res>
    implements $TimetableCopyWith<$Res> {
  factory _$$TimetableImplCopyWith(
          _$TimetableImpl value, $Res Function(_$TimetableImpl) then) =
      __$$TimetableImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, List<Lecture>? lectures});
}

/// @nodoc
class __$$TimetableImplCopyWithImpl<$Res>
    extends _$TimetableCopyWithImpl<$Res, _$TimetableImpl>
    implements _$$TimetableImplCopyWith<$Res> {
  __$$TimetableImplCopyWithImpl(
      _$TimetableImpl _value, $Res Function(_$TimetableImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? lectures = freezed,
  }) {
    return _then(_$TimetableImpl(
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
class _$TimetableImpl implements _Timetable {
  const _$TimetableImpl(
      {required this.id, required this.name, final List<Lecture>? lectures})
      : _lectures = lectures;

  factory _$TimetableImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimetableImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimetableImpl &&
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
  _$$TimetableImplCopyWith<_$TimetableImpl> get copyWith =>
      __$$TimetableImplCopyWithImpl<_$TimetableImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimetableImplToJson(
      this,
    );
  }
}

abstract class _Timetable implements Timetable {
  const factory _Timetable(
      {required final int id,
      required final String name,
      final List<Lecture>? lectures}) = _$TimetableImpl;

  factory _Timetable.fromJson(Map<String, dynamic> json) =
      _$TimetableImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  List<Lecture>? get lectures;
  @override
  @JsonKey(ignore: true)
  _$$TimetableImplCopyWith<_$TimetableImpl> get copyWith =>
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
abstract class _$$LectureImplCopyWith<$Res> implements $LectureCopyWith<$Res> {
  factory _$$LectureImplCopyWith(
          _$LectureImpl value, $Res Function(_$LectureImpl) then) =
      __$$LectureImplCopyWithImpl<$Res>;
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
class __$$LectureImplCopyWithImpl<$Res>
    extends _$LectureCopyWithImpl<$Res, _$LectureImpl>
    implements _$$LectureImplCopyWith<$Res> {
  __$$LectureImplCopyWithImpl(
      _$LectureImpl _value, $Res Function(_$LectureImpl) _then)
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
    return _then(_$LectureImpl(
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
class _$LectureImpl implements _Lecture {
  const _$LectureImpl(
      {required this.name,
      required this.memo,
      required this.type,
      required this.color,
      required final List<LectureTime> times})
      : _times = times;

  factory _$LectureImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureImpl &&
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
  _$$LectureImplCopyWith<_$LectureImpl> get copyWith =>
      __$$LectureImplCopyWithImpl<_$LectureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureImplToJson(
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
      required final List<LectureTime> times}) = _$LectureImpl;

  factory _Lecture.fromJson(Map<String, dynamic> json) = _$LectureImpl.fromJson;

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
  _$$LectureImplCopyWith<_$LectureImpl> get copyWith =>
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
  String? get place => throw _privateConstructorUsedError;

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
  $Res call({String start, String end, String week, String? place});
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
    Object? place = freezed,
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
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LectureTimeImplCopyWith<$Res>
    implements $LectureTimeCopyWith<$Res> {
  factory _$$LectureTimeImplCopyWith(
          _$LectureTimeImpl value, $Res Function(_$LectureTimeImpl) then) =
      __$$LectureTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String start, String end, String week, String? place});
}

/// @nodoc
class __$$LectureTimeImplCopyWithImpl<$Res>
    extends _$LectureTimeCopyWithImpl<$Res, _$LectureTimeImpl>
    implements _$$LectureTimeImplCopyWith<$Res> {
  __$$LectureTimeImplCopyWithImpl(
      _$LectureTimeImpl _value, $Res Function(_$LectureTimeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? start = null,
    Object? end = null,
    Object? week = null,
    Object? place = freezed,
  }) {
    return _then(_$LectureTimeImpl(
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
      place: freezed == place
          ? _value.place
          : place // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LectureTimeImpl implements _LectureTime {
  const _$LectureTimeImpl(
      {required this.start, required this.end, required this.week, this.place});

  factory _$LectureTimeImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureTimeImplFromJson(json);

  @override
  final String start;
  @override
  final String end;
  @override
  final String week;
  @override
  final String? place;

  @override
  String toString() {
    return 'LectureTime(start: $start, end: $end, week: $week, place: $place)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureTimeImpl &&
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
  _$$LectureTimeImplCopyWith<_$LectureTimeImpl> get copyWith =>
      __$$LectureTimeImplCopyWithImpl<_$LectureTimeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureTimeImplToJson(
      this,
    );
  }
}

abstract class _LectureTime implements LectureTime {
  const factory _LectureTime(
      {required final String start,
      required final String end,
      required final String week,
      final String? place}) = _$LectureTimeImpl;

  factory _LectureTime.fromJson(Map<String, dynamic> json) =
      _$LectureTimeImpl.fromJson;

  @override
  String get start;
  @override
  String get end;
  @override
  String get week;
  @override
  String? get place;
  @override
  @JsonKey(ignore: true)
  _$$LectureTimeImplCopyWith<_$LectureTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LectureInfo _$LectureInfoFromJson(Map<String, dynamic> json) {
  return _LectureInfo.fromJson(json);
}

/// @nodoc
mixin _$LectureInfo {
  String? get major => throw _privateConstructorUsedError;
  int? get grade => throw _privateConstructorUsedError;
  String get lectureCode => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get professor => throw _privateConstructorUsedError;
  int get classNumber => throw _privateConstructorUsedError;
  int get credit => throw _privateConstructorUsedError;
  List<LectureTime> get times => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureInfoCopyWith<LectureInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureInfoCopyWith<$Res> {
  factory $LectureInfoCopyWith(
          LectureInfo value, $Res Function(LectureInfo) then) =
      _$LectureInfoCopyWithImpl<$Res, LectureInfo>;
  @useResult
  $Res call(
      {String? major,
      int? grade,
      String lectureCode,
      String category,
      String name,
      String professor,
      int classNumber,
      int credit,
      List<LectureTime> times});
}

/// @nodoc
class _$LectureInfoCopyWithImpl<$Res, $Val extends LectureInfo>
    implements $LectureInfoCopyWith<$Res> {
  _$LectureInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = freezed,
    Object? grade = freezed,
    Object? lectureCode = null,
    Object? category = null,
    Object? name = null,
    Object? professor = null,
    Object? classNumber = null,
    Object? credit = null,
    Object? times = null,
  }) {
    return _then(_value.copyWith(
      major: freezed == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int?,
      lectureCode: null == lectureCode
          ? _value.lectureCode
          : lectureCode // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      professor: null == professor
          ? _value.professor
          : professor // ignore: cast_nullable_to_non_nullable
              as String,
      classNumber: null == classNumber
          ? _value.classNumber
          : classNumber // ignore: cast_nullable_to_non_nullable
              as int,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      times: null == times
          ? _value.times
          : times // ignore: cast_nullable_to_non_nullable
              as List<LectureTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LectureInfoImplCopyWith<$Res>
    implements $LectureInfoCopyWith<$Res> {
  factory _$$LectureInfoImplCopyWith(
          _$LectureInfoImpl value, $Res Function(_$LectureInfoImpl) then) =
      __$$LectureInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? major,
      int? grade,
      String lectureCode,
      String category,
      String name,
      String professor,
      int classNumber,
      int credit,
      List<LectureTime> times});
}

/// @nodoc
class __$$LectureInfoImplCopyWithImpl<$Res>
    extends _$LectureInfoCopyWithImpl<$Res, _$LectureInfoImpl>
    implements _$$LectureInfoImplCopyWith<$Res> {
  __$$LectureInfoImplCopyWithImpl(
      _$LectureInfoImpl _value, $Res Function(_$LectureInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = freezed,
    Object? grade = freezed,
    Object? lectureCode = null,
    Object? category = null,
    Object? name = null,
    Object? professor = null,
    Object? classNumber = null,
    Object? credit = null,
    Object? times = null,
  }) {
    return _then(_$LectureInfoImpl(
      major: freezed == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String?,
      grade: freezed == grade
          ? _value.grade
          : grade // ignore: cast_nullable_to_non_nullable
              as int?,
      lectureCode: null == lectureCode
          ? _value.lectureCode
          : lectureCode // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      professor: null == professor
          ? _value.professor
          : professor // ignore: cast_nullable_to_non_nullable
              as String,
      classNumber: null == classNumber
          ? _value.classNumber
          : classNumber // ignore: cast_nullable_to_non_nullable
              as int,
      credit: null == credit
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as int,
      times: null == times
          ? _value._times
          : times // ignore: cast_nullable_to_non_nullable
              as List<LectureTime>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LectureInfoImpl implements _LectureInfo {
  const _$LectureInfoImpl(
      {this.major,
      this.grade,
      required this.lectureCode,
      required this.category,
      required this.name,
      required this.professor,
      required this.classNumber,
      required this.credit,
      required final List<LectureTime> times})
      : _times = times;

  factory _$LectureInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$LectureInfoImplFromJson(json);

  @override
  final String? major;
  @override
  final int? grade;
  @override
  final String lectureCode;
  @override
  final String category;
  @override
  final String name;
  @override
  final String professor;
  @override
  final int classNumber;
  @override
  final int credit;
  final List<LectureTime> _times;
  @override
  List<LectureTime> get times {
    if (_times is EqualUnmodifiableListView) return _times;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_times);
  }

  @override
  String toString() {
    return 'LectureInfo(major: $major, grade: $grade, lectureCode: $lectureCode, category: $category, name: $name, professor: $professor, classNumber: $classNumber, credit: $credit, times: $times)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LectureInfoImpl &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.grade, grade) || other.grade == grade) &&
            (identical(other.lectureCode, lectureCode) ||
                other.lectureCode == lectureCode) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.professor, professor) ||
                other.professor == professor) &&
            (identical(other.classNumber, classNumber) ||
                other.classNumber == classNumber) &&
            (identical(other.credit, credit) || other.credit == credit) &&
            const DeepCollectionEquality().equals(other._times, _times));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      major,
      grade,
      lectureCode,
      category,
      name,
      professor,
      classNumber,
      credit,
      const DeepCollectionEquality().hash(_times));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LectureInfoImplCopyWith<_$LectureInfoImpl> get copyWith =>
      __$$LectureInfoImplCopyWithImpl<_$LectureInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LectureInfoImplToJson(
      this,
    );
  }
}

abstract class _LectureInfo implements LectureInfo {
  const factory _LectureInfo(
      {final String? major,
      final int? grade,
      required final String lectureCode,
      required final String category,
      required final String name,
      required final String professor,
      required final int classNumber,
      required final int credit,
      required final List<LectureTime> times}) = _$LectureInfoImpl;

  factory _LectureInfo.fromJson(Map<String, dynamic> json) =
      _$LectureInfoImpl.fromJson;

  @override
  String? get major;
  @override
  int? get grade;
  @override
  String get lectureCode;
  @override
  String get category;
  @override
  String get name;
  @override
  String get professor;
  @override
  int get classNumber;
  @override
  int get credit;
  @override
  List<LectureTime> get times;
  @override
  @JsonKey(ignore: true)
  _$$LectureInfoImplCopyWith<_$LectureInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
