// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusList _$BusListFromJson(Map<String, dynamic> json) {
  return _BusList.fromJson(json);
}

/// @nodoc
mixin _$BusList {
  String get capturedAt => throw _privateConstructorUsedError;
  List<Bus> get busArrivalList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusListCopyWith<BusList> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusListCopyWith<$Res> {
  factory $BusListCopyWith(BusList value, $Res Function(BusList) then) =
      _$BusListCopyWithImpl<$Res, BusList>;
  @useResult
  $Res call({String capturedAt, List<Bus> busArrivalList});
}

/// @nodoc
class _$BusListCopyWithImpl<$Res, $Val extends BusList>
    implements $BusListCopyWith<$Res> {
  _$BusListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capturedAt = null,
    Object? busArrivalList = null,
  }) {
    return _then(_value.copyWith(
      capturedAt: null == capturedAt
          ? _value.capturedAt
          : capturedAt // ignore: cast_nullable_to_non_nullable
              as String,
      busArrivalList: null == busArrivalList
          ? _value.busArrivalList
          : busArrivalList // ignore: cast_nullable_to_non_nullable
              as List<Bus>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusListImplCopyWith<$Res> implements $BusListCopyWith<$Res> {
  factory _$$BusListImplCopyWith(
          _$BusListImpl value, $Res Function(_$BusListImpl) then) =
      __$$BusListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String capturedAt, List<Bus> busArrivalList});
}

/// @nodoc
class __$$BusListImplCopyWithImpl<$Res>
    extends _$BusListCopyWithImpl<$Res, _$BusListImpl>
    implements _$$BusListImplCopyWith<$Res> {
  __$$BusListImplCopyWithImpl(
      _$BusListImpl _value, $Res Function(_$BusListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? capturedAt = null,
    Object? busArrivalList = null,
  }) {
    return _then(_$BusListImpl(
      capturedAt: null == capturedAt
          ? _value.capturedAt
          : capturedAt // ignore: cast_nullable_to_non_nullable
              as String,
      busArrivalList: null == busArrivalList
          ? _value._busArrivalList
          : busArrivalList // ignore: cast_nullable_to_non_nullable
              as List<Bus>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusListImpl implements _BusList {
  const _$BusListImpl(
      {required this.capturedAt, required final List<Bus> busArrivalList})
      : _busArrivalList = busArrivalList;

  factory _$BusListImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusListImplFromJson(json);

  @override
  final String capturedAt;
  final List<Bus> _busArrivalList;
  @override
  List<Bus> get busArrivalList {
    if (_busArrivalList is EqualUnmodifiableListView) return _busArrivalList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_busArrivalList);
  }

  @override
  String toString() {
    return 'BusList(capturedAt: $capturedAt, busArrivalList: $busArrivalList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusListImpl &&
            (identical(other.capturedAt, capturedAt) ||
                other.capturedAt == capturedAt) &&
            const DeepCollectionEquality()
                .equals(other._busArrivalList, _busArrivalList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, capturedAt,
      const DeepCollectionEquality().hash(_busArrivalList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusListImplCopyWith<_$BusListImpl> get copyWith =>
      __$$BusListImplCopyWithImpl<_$BusListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusListImplToJson(
      this,
    );
  }
}

abstract class _BusList implements BusList {
  const factory _BusList(
      {required final String capturedAt,
      required final List<Bus> busArrivalList}) = _$BusListImpl;

  factory _BusList.fromJson(Map<String, dynamic> json) = _$BusListImpl.fromJson;

  @override
  String get capturedAt;
  @override
  List<Bus> get busArrivalList;
  @override
  @JsonKey(ignore: true)
  _$$BusListImplCopyWith<_$BusListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BusInfo _$BusInfoFromJson(Map<String, dynamic> json) {
  return _BusInfo.fromJson(json);
}

/// @nodoc
mixin _$BusInfo {
  BusList get jungmoonBus => throw _privateConstructorUsedError;
  BusList get gomsangBus => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusInfoCopyWith<BusInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusInfoCopyWith<$Res> {
  factory $BusInfoCopyWith(BusInfo value, $Res Function(BusInfo) then) =
      _$BusInfoCopyWithImpl<$Res, BusInfo>;
  @useResult
  $Res call({BusList jungmoonBus, BusList gomsangBus});

  $BusListCopyWith<$Res> get jungmoonBus;
  $BusListCopyWith<$Res> get gomsangBus;
}

/// @nodoc
class _$BusInfoCopyWithImpl<$Res, $Val extends BusInfo>
    implements $BusInfoCopyWith<$Res> {
  _$BusInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jungmoonBus = null,
    Object? gomsangBus = null,
  }) {
    return _then(_value.copyWith(
      jungmoonBus: null == jungmoonBus
          ? _value.jungmoonBus
          : jungmoonBus // ignore: cast_nullable_to_non_nullable
              as BusList,
      gomsangBus: null == gomsangBus
          ? _value.gomsangBus
          : gomsangBus // ignore: cast_nullable_to_non_nullable
              as BusList,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BusListCopyWith<$Res> get jungmoonBus {
    return $BusListCopyWith<$Res>(_value.jungmoonBus, (value) {
      return _then(_value.copyWith(jungmoonBus: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BusListCopyWith<$Res> get gomsangBus {
    return $BusListCopyWith<$Res>(_value.gomsangBus, (value) {
      return _then(_value.copyWith(gomsangBus: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BusInfoImplCopyWith<$Res> implements $BusInfoCopyWith<$Res> {
  factory _$$BusInfoImplCopyWith(
          _$BusInfoImpl value, $Res Function(_$BusInfoImpl) then) =
      __$$BusInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BusList jungmoonBus, BusList gomsangBus});

  @override
  $BusListCopyWith<$Res> get jungmoonBus;
  @override
  $BusListCopyWith<$Res> get gomsangBus;
}

/// @nodoc
class __$$BusInfoImplCopyWithImpl<$Res>
    extends _$BusInfoCopyWithImpl<$Res, _$BusInfoImpl>
    implements _$$BusInfoImplCopyWith<$Res> {
  __$$BusInfoImplCopyWithImpl(
      _$BusInfoImpl _value, $Res Function(_$BusInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jungmoonBus = null,
    Object? gomsangBus = null,
  }) {
    return _then(_$BusInfoImpl(
      jungmoonBus: null == jungmoonBus
          ? _value.jungmoonBus
          : jungmoonBus // ignore: cast_nullable_to_non_nullable
              as BusList,
      gomsangBus: null == gomsangBus
          ? _value.gomsangBus
          : gomsangBus // ignore: cast_nullable_to_non_nullable
              as BusList,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusInfoImpl implements _BusInfo {
  const _$BusInfoImpl({required this.jungmoonBus, required this.gomsangBus});

  factory _$BusInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusInfoImplFromJson(json);

  @override
  final BusList jungmoonBus;
  @override
  final BusList gomsangBus;

  @override
  String toString() {
    return 'BusInfo(jungmoonBus: $jungmoonBus, gomsangBus: $gomsangBus)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusInfoImpl &&
            (identical(other.jungmoonBus, jungmoonBus) ||
                other.jungmoonBus == jungmoonBus) &&
            (identical(other.gomsangBus, gomsangBus) ||
                other.gomsangBus == gomsangBus));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, jungmoonBus, gomsangBus);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusInfoImplCopyWith<_$BusInfoImpl> get copyWith =>
      __$$BusInfoImplCopyWithImpl<_$BusInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusInfoImplToJson(
      this,
    );
  }
}

abstract class _BusInfo implements BusInfo {
  const factory _BusInfo(
      {required final BusList jungmoonBus,
      required final BusList gomsangBus}) = _$BusInfoImpl;

  factory _BusInfo.fromJson(Map<String, dynamic> json) = _$BusInfoImpl.fromJson;

  @override
  BusList get jungmoonBus;
  @override
  BusList get gomsangBus;
  @override
  @JsonKey(ignore: true)
  _$$BusInfoImplCopyWith<_$BusInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Bus _$BusFromJson(Map<String, dynamic> json) {
  return _Bus.fromJson(json);
}

/// @nodoc
mixin _$Bus {
  int get locationNo1 => throw _privateConstructorUsedError;
  int get predictTime1 => throw _privateConstructorUsedError;
  String get busNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusCopyWith<Bus> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusCopyWith<$Res> {
  factory $BusCopyWith(Bus value, $Res Function(Bus) then) =
      _$BusCopyWithImpl<$Res, Bus>;
  @useResult
  $Res call({int locationNo1, int predictTime1, String busNo});
}

/// @nodoc
class _$BusCopyWithImpl<$Res, $Val extends Bus> implements $BusCopyWith<$Res> {
  _$BusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationNo1 = null,
    Object? predictTime1 = null,
    Object? busNo = null,
  }) {
    return _then(_value.copyWith(
      locationNo1: null == locationNo1
          ? _value.locationNo1
          : locationNo1 // ignore: cast_nullable_to_non_nullable
              as int,
      predictTime1: null == predictTime1
          ? _value.predictTime1
          : predictTime1 // ignore: cast_nullable_to_non_nullable
              as int,
      busNo: null == busNo
          ? _value.busNo
          : busNo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusImplCopyWith<$Res> implements $BusCopyWith<$Res> {
  factory _$$BusImplCopyWith(_$BusImpl value, $Res Function(_$BusImpl) then) =
      __$$BusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int locationNo1, int predictTime1, String busNo});
}

/// @nodoc
class __$$BusImplCopyWithImpl<$Res> extends _$BusCopyWithImpl<$Res, _$BusImpl>
    implements _$$BusImplCopyWith<$Res> {
  __$$BusImplCopyWithImpl(_$BusImpl _value, $Res Function(_$BusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationNo1 = null,
    Object? predictTime1 = null,
    Object? busNo = null,
  }) {
    return _then(_$BusImpl(
      locationNo1: null == locationNo1
          ? _value.locationNo1
          : locationNo1 // ignore: cast_nullable_to_non_nullable
              as int,
      predictTime1: null == predictTime1
          ? _value.predictTime1
          : predictTime1 // ignore: cast_nullable_to_non_nullable
              as int,
      busNo: null == busNo
          ? _value.busNo
          : busNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusImpl implements _Bus {
  const _$BusImpl(
      {this.locationNo1 = 0, this.predictTime1 = 0, required this.busNo});

  factory _$BusImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusImplFromJson(json);

  @override
  @JsonKey()
  final int locationNo1;
  @override
  @JsonKey()
  final int predictTime1;
  @override
  final String busNo;

  @override
  String toString() {
    return 'Bus(locationNo1: $locationNo1, predictTime1: $predictTime1, busNo: $busNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusImpl &&
            (identical(other.locationNo1, locationNo1) ||
                other.locationNo1 == locationNo1) &&
            (identical(other.predictTime1, predictTime1) ||
                other.predictTime1 == predictTime1) &&
            (identical(other.busNo, busNo) || other.busNo == busNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, locationNo1, predictTime1, busNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusImplCopyWith<_$BusImpl> get copyWith =>
      __$$BusImplCopyWithImpl<_$BusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusImplToJson(
      this,
    );
  }
}

abstract class _Bus implements Bus {
  const factory _Bus(
      {final int locationNo1,
      final int predictTime1,
      required final String busNo}) = _$BusImpl;

  factory _Bus.fromJson(Map<String, dynamic> json) = _$BusImpl.fromJson;

  @override
  int get locationNo1;
  @override
  int get predictTime1;
  @override
  String get busNo;
  @override
  @JsonKey(ignore: true)
  _$$BusImplCopyWith<_$BusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
