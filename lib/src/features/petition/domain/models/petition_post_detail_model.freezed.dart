// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'petition_post_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetitionPostDetailModel _$PetitionPostDetailModelFromJson(
    Map<String, dynamic> json) {
  return _PetitionPostDetailModel.fromJson(json);
}

/// @nodoc
mixin _$PetitionPostDetailModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;
  String get createdAt =>
      throw _privateConstructorUsedError; //required List<PostFile?> files,
//required List<PostImage?> images,
  String get status => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  int get agreeCount => throw _privateConstructorUsedError;
  List<PetitionStatisticModel?> get statisticList =>
      throw _privateConstructorUsedError;
  bool get agree => throw _privateConstructorUsedError;
  bool get mine => throw _privateConstructorUsedError;
  bool get blinded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetitionPostDetailModelCopyWith<PetitionPostDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetitionPostDetailModelCopyWith<$Res> {
  factory $PetitionPostDetailModelCopyWith(PetitionPostDetailModel value,
          $Res Function(PetitionPostDetailModel) then) =
      _$PetitionPostDetailModelCopyWithImpl<$Res, PetitionPostDetailModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String body,
      String? answer,
      String createdAt,
      String status,
      String expiresAt,
      int agreeCount,
      List<PetitionStatisticModel?> statisticList,
      bool agree,
      bool mine,
      bool blinded});
}

/// @nodoc
class _$PetitionPostDetailModelCopyWithImpl<$Res,
        $Val extends PetitionPostDetailModel>
    implements $PetitionPostDetailModelCopyWith<$Res> {
  _$PetitionPostDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? body = null,
    Object? answer = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? agreeCount = null,
    Object? statisticList = null,
    Object? agree = null,
    Object? mine = null,
    Object? blinded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      statisticList: null == statisticList
          ? _value.statisticList
          : statisticList // ignore: cast_nullable_to_non_nullable
              as List<PetitionStatisticModel?>,
      agree: null == agree
          ? _value.agree
          : agree // ignore: cast_nullable_to_non_nullable
              as bool,
      mine: null == mine
          ? _value.mine
          : mine // ignore: cast_nullable_to_non_nullable
              as bool,
      blinded: null == blinded
          ? _value.blinded
          : blinded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PetitionPostDetailModelImplCopyWith<$Res>
    implements $PetitionPostDetailModelCopyWith<$Res> {
  factory _$$PetitionPostDetailModelImplCopyWith(
          _$PetitionPostDetailModelImpl value,
          $Res Function(_$PetitionPostDetailModelImpl) then) =
      __$$PetitionPostDetailModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String body,
      String? answer,
      String createdAt,
      String status,
      String expiresAt,
      int agreeCount,
      List<PetitionStatisticModel?> statisticList,
      bool agree,
      bool mine,
      bool blinded});
}

/// @nodoc
class __$$PetitionPostDetailModelImplCopyWithImpl<$Res>
    extends _$PetitionPostDetailModelCopyWithImpl<$Res,
        _$PetitionPostDetailModelImpl>
    implements _$$PetitionPostDetailModelImplCopyWith<$Res> {
  __$$PetitionPostDetailModelImplCopyWithImpl(
      _$PetitionPostDetailModelImpl _value,
      $Res Function(_$PetitionPostDetailModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? body = null,
    Object? answer = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? agreeCount = null,
    Object? statisticList = null,
    Object? agree = null,
    Object? mine = null,
    Object? blinded = null,
  }) {
    return _then(_$PetitionPostDetailModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      answer: freezed == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      statisticList: null == statisticList
          ? _value._statisticList
          : statisticList // ignore: cast_nullable_to_non_nullable
              as List<PetitionStatisticModel?>,
      agree: null == agree
          ? _value.agree
          : agree // ignore: cast_nullable_to_non_nullable
              as bool,
      mine: null == mine
          ? _value.mine
          : mine // ignore: cast_nullable_to_non_nullable
              as bool,
      blinded: null == blinded
          ? _value.blinded
          : blinded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PetitionPostDetailModelImpl implements _PetitionPostDetailModel {
  const _$PetitionPostDetailModelImpl(
      {required this.id,
      required this.title,
      required this.author,
      required this.body,
      this.answer,
      required this.createdAt,
      required this.status,
      required this.expiresAt,
      required this.agreeCount,
      final List<PetitionStatisticModel?> statisticList = const [],
      required this.agree,
      required this.mine,
      required this.blinded})
      : _statisticList = statisticList;

  factory _$PetitionPostDetailModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetitionPostDetailModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String author;
  @override
  final String body;
  @override
  final String? answer;
  @override
  final String createdAt;
//required List<PostFile?> files,
//required List<PostImage?> images,
  @override
  final String status;
  @override
  final String expiresAt;
  @override
  final int agreeCount;
  final List<PetitionStatisticModel?> _statisticList;
  @override
  @JsonKey()
  List<PetitionStatisticModel?> get statisticList {
    if (_statisticList is EqualUnmodifiableListView) return _statisticList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_statisticList);
  }

  @override
  final bool agree;
  @override
  final bool mine;
  @override
  final bool blinded;

  @override
  String toString() {
    return 'PetitionPostDetailModel(id: $id, title: $title, author: $author, body: $body, answer: $answer, createdAt: $createdAt, status: $status, expiresAt: $expiresAt, agreeCount: $agreeCount, statisticList: $statisticList, agree: $agree, mine: $mine, blinded: $blinded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetitionPostDetailModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.agreeCount, agreeCount) ||
                other.agreeCount == agreeCount) &&
            const DeepCollectionEquality()
                .equals(other._statisticList, _statisticList) &&
            (identical(other.agree, agree) || other.agree == agree) &&
            (identical(other.mine, mine) || other.mine == mine) &&
            (identical(other.blinded, blinded) || other.blinded == blinded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      author,
      body,
      answer,
      createdAt,
      status,
      expiresAt,
      agreeCount,
      const DeepCollectionEquality().hash(_statisticList),
      agree,
      mine,
      blinded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PetitionPostDetailModelImplCopyWith<_$PetitionPostDetailModelImpl>
      get copyWith => __$$PetitionPostDetailModelImplCopyWithImpl<
          _$PetitionPostDetailModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetitionPostDetailModelImplToJson(
      this,
    );
  }
}

abstract class _PetitionPostDetailModel implements PetitionPostDetailModel {
  const factory _PetitionPostDetailModel(
      {required final int id,
      required final String title,
      required final String author,
      required final String body,
      final String? answer,
      required final String createdAt,
      required final String status,
      required final String expiresAt,
      required final int agreeCount,
      final List<PetitionStatisticModel?> statisticList,
      required final bool agree,
      required final bool mine,
      required final bool blinded}) = _$PetitionPostDetailModelImpl;

  factory _PetitionPostDetailModel.fromJson(Map<String, dynamic> json) =
      _$PetitionPostDetailModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get author;
  @override
  String get body;
  @override
  String? get answer;
  @override
  String get createdAt;
  @override //required List<PostFile?> files,
//required List<PostImage?> images,
  String get status;
  @override
  String get expiresAt;
  @override
  int get agreeCount;
  @override
  List<PetitionStatisticModel?> get statisticList;
  @override
  bool get agree;
  @override
  bool get mine;
  @override
  bool get blinded;
  @override
  @JsonKey(ignore: true)
  _$$PetitionPostDetailModelImplCopyWith<_$PetitionPostDetailModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
