// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_arrival_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusArrivalInfoModel _$BusArrivalInfoModelFromJson(Map<String, dynamic> json) {
  return _BusArrivalInfoModel.fromJson(json);
}

/// @nodoc
mixin _$BusArrivalInfoModel {
  @JsonKey(name: 'busArrivalEntranceList')
  List<BusModel> get entranceBusList => throw _privateConstructorUsedError;
  @JsonKey(name: 'busArrivalPlazaList')
  List<BusModel> get plazaBusList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusArrivalInfoModelCopyWith<BusArrivalInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusArrivalInfoModelCopyWith<$Res> {
  factory $BusArrivalInfoModelCopyWith(
          BusArrivalInfoModel value, $Res Function(BusArrivalInfoModel) then) =
      _$BusArrivalInfoModelCopyWithImpl<$Res, BusArrivalInfoModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'busArrivalEntranceList') List<BusModel> entranceBusList,
      @JsonKey(name: 'busArrivalPlazaList') List<BusModel> plazaBusList});
}

/// @nodoc
class _$BusArrivalInfoModelCopyWithImpl<$Res, $Val extends BusArrivalInfoModel>
    implements $BusArrivalInfoModelCopyWith<$Res> {
  _$BusArrivalInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entranceBusList = null,
    Object? plazaBusList = null,
  }) {
    return _then(_value.copyWith(
      entranceBusList: null == entranceBusList
          ? _value.entranceBusList
          : entranceBusList // ignore: cast_nullable_to_non_nullable
              as List<BusModel>,
      plazaBusList: null == plazaBusList
          ? _value.plazaBusList
          : plazaBusList // ignore: cast_nullable_to_non_nullable
              as List<BusModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusArrivalInfoModelImplCopyWith<$Res>
    implements $BusArrivalInfoModelCopyWith<$Res> {
  factory _$$BusArrivalInfoModelImplCopyWith(_$BusArrivalInfoModelImpl value,
          $Res Function(_$BusArrivalInfoModelImpl) then) =
      __$$BusArrivalInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'busArrivalEntranceList') List<BusModel> entranceBusList,
      @JsonKey(name: 'busArrivalPlazaList') List<BusModel> plazaBusList});
}

/// @nodoc
class __$$BusArrivalInfoModelImplCopyWithImpl<$Res>
    extends _$BusArrivalInfoModelCopyWithImpl<$Res, _$BusArrivalInfoModelImpl>
    implements _$$BusArrivalInfoModelImplCopyWith<$Res> {
  __$$BusArrivalInfoModelImplCopyWithImpl(_$BusArrivalInfoModelImpl _value,
      $Res Function(_$BusArrivalInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entranceBusList = null,
    Object? plazaBusList = null,
  }) {
    return _then(_$BusArrivalInfoModelImpl(
      entranceBusList: null == entranceBusList
          ? _value._entranceBusList
          : entranceBusList // ignore: cast_nullable_to_non_nullable
              as List<BusModel>,
      plazaBusList: null == plazaBusList
          ? _value._plazaBusList
          : plazaBusList // ignore: cast_nullable_to_non_nullable
              as List<BusModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusArrivalInfoModelImpl implements _BusArrivalInfoModel {
  const _$BusArrivalInfoModelImpl(
      {@JsonKey(name: 'busArrivalEntranceList')
      required final List<BusModel> entranceBusList,
      @JsonKey(name: 'busArrivalPlazaList')
      required final List<BusModel> plazaBusList})
      : _entranceBusList = entranceBusList,
        _plazaBusList = plazaBusList;

  factory _$BusArrivalInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusArrivalInfoModelImplFromJson(json);

  final List<BusModel> _entranceBusList;
  @override
  @JsonKey(name: 'busArrivalEntranceList')
  List<BusModel> get entranceBusList {
    if (_entranceBusList is EqualUnmodifiableListView) return _entranceBusList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entranceBusList);
  }

  final List<BusModel> _plazaBusList;
  @override
  @JsonKey(name: 'busArrivalPlazaList')
  List<BusModel> get plazaBusList {
    if (_plazaBusList is EqualUnmodifiableListView) return _plazaBusList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_plazaBusList);
  }

  @override
  String toString() {
    return 'BusArrivalInfoModel(entranceBusList: $entranceBusList, plazaBusList: $plazaBusList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusArrivalInfoModelImpl &&
            const DeepCollectionEquality()
                .equals(other._entranceBusList, _entranceBusList) &&
            const DeepCollectionEquality()
                .equals(other._plazaBusList, _plazaBusList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_entranceBusList),
      const DeepCollectionEquality().hash(_plazaBusList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusArrivalInfoModelImplCopyWith<_$BusArrivalInfoModelImpl> get copyWith =>
      __$$BusArrivalInfoModelImplCopyWithImpl<_$BusArrivalInfoModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusArrivalInfoModelImplToJson(
      this,
    );
  }
}

abstract class _BusArrivalInfoModel implements BusArrivalInfoModel {
  const factory _BusArrivalInfoModel(
      {@JsonKey(name: 'busArrivalEntranceList')
      required final List<BusModel> entranceBusList,
      @JsonKey(name: 'busArrivalPlazaList')
      required final List<BusModel> plazaBusList}) = _$BusArrivalInfoModelImpl;

  factory _BusArrivalInfoModel.fromJson(Map<String, dynamic> json) =
      _$BusArrivalInfoModelImpl.fromJson;

  @override
  @JsonKey(name: 'busArrivalEntranceList')
  List<BusModel> get entranceBusList;
  @override
  @JsonKey(name: 'busArrivalPlazaList')
  List<BusModel> get plazaBusList;
  @override
  @JsonKey(ignore: true)
  _$$BusArrivalInfoModelImplCopyWith<_$BusArrivalInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
