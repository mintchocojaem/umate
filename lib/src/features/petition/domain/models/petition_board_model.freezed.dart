// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'petition_board_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetitionBoardModel _$PetitionBoardModelFromJson(Map<String, dynamic> json) {
  return _PetitionBoardModel.fromJson(json);
}

/// @nodoc
mixin _$PetitionBoardModel {
  List<PetitionPostPreviewModel> get content =>
      throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get totalElements => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  bool get first => throw _privateConstructorUsedError;
  bool get last => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetitionBoardModelCopyWith<PetitionBoardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetitionBoardModelCopyWith<$Res> {
  factory $PetitionBoardModelCopyWith(
          PetitionBoardModel value, $Res Function(PetitionBoardModel) then) =
      _$PetitionBoardModelCopyWithImpl<$Res, PetitionBoardModel>;
  @useResult
  $Res call(
      {List<PetitionPostPreviewModel> content,
      bool hasNext,
      int totalPages,
      int totalElements,
      int page,
      int size,
      bool first,
      bool last});
}

/// @nodoc
class _$PetitionBoardModelCopyWithImpl<$Res, $Val extends PetitionBoardModel>
    implements $PetitionBoardModelCopyWith<$Res> {
  _$PetitionBoardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? hasNext = null,
    Object? totalPages = null,
    Object? totalElements = null,
    Object? page = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PetitionPostPreviewModel>,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalElements: null == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      first: null == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as bool,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PetitionBoardModelImplCopyWith<$Res>
    implements $PetitionBoardModelCopyWith<$Res> {
  factory _$$PetitionBoardModelImplCopyWith(_$PetitionBoardModelImpl value,
          $Res Function(_$PetitionBoardModelImpl) then) =
      __$$PetitionBoardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PetitionPostPreviewModel> content,
      bool hasNext,
      int totalPages,
      int totalElements,
      int page,
      int size,
      bool first,
      bool last});
}

/// @nodoc
class __$$PetitionBoardModelImplCopyWithImpl<$Res>
    extends _$PetitionBoardModelCopyWithImpl<$Res, _$PetitionBoardModelImpl>
    implements _$$PetitionBoardModelImplCopyWith<$Res> {
  __$$PetitionBoardModelImplCopyWithImpl(_$PetitionBoardModelImpl _value,
      $Res Function(_$PetitionBoardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? hasNext = null,
    Object? totalPages = null,
    Object? totalElements = null,
    Object? page = null,
    Object? size = null,
    Object? first = null,
    Object? last = null,
  }) {
    return _then(_$PetitionBoardModelImpl(
      content: null == content
          ? _value._content
          : content // ignore: cast_nullable_to_non_nullable
              as List<PetitionPostPreviewModel>,
      hasNext: null == hasNext
          ? _value.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalElements: null == totalElements
          ? _value.totalElements
          : totalElements // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      first: null == first
          ? _value.first
          : first // ignore: cast_nullable_to_non_nullable
              as bool,
      last: null == last
          ? _value.last
          : last // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PetitionBoardModelImpl implements _PetitionBoardModel {
  const _$PetitionBoardModelImpl(
      {required final List<PetitionPostPreviewModel> content,
      required this.hasNext,
      required this.totalPages,
      required this.totalElements,
      required this.page,
      required this.size,
      required this.first,
      required this.last})
      : _content = content;

  factory _$PetitionBoardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetitionBoardModelImplFromJson(json);

  final List<PetitionPostPreviewModel> _content;
  @override
  List<PetitionPostPreviewModel> get content {
    if (_content is EqualUnmodifiableListView) return _content;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_content);
  }

  @override
  final bool hasNext;
  @override
  final int totalPages;
  @override
  final int totalElements;
  @override
  final int page;
  @override
  final int size;
  @override
  final bool first;
  @override
  final bool last;

  @override
  String toString() {
    return 'PetitionBoardModel(content: $content, hasNext: $hasNext, totalPages: $totalPages, totalElements: $totalElements, page: $page, size: $size, first: $first, last: $last)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetitionBoardModelImpl &&
            const DeepCollectionEquality().equals(other._content, _content) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalElements, totalElements) ||
                other.totalElements == totalElements) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.first, first) || other.first == first) &&
            (identical(other.last, last) || other.last == last));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_content),
      hasNext,
      totalPages,
      totalElements,
      page,
      size,
      first,
      last);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PetitionBoardModelImplCopyWith<_$PetitionBoardModelImpl> get copyWith =>
      __$$PetitionBoardModelImplCopyWithImpl<_$PetitionBoardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetitionBoardModelImplToJson(
      this,
    );
  }
}

abstract class _PetitionBoardModel implements PetitionBoardModel {
  const factory _PetitionBoardModel(
      {required final List<PetitionPostPreviewModel> content,
      required final bool hasNext,
      required final int totalPages,
      required final int totalElements,
      required final int page,
      required final int size,
      required final bool first,
      required final bool last}) = _$PetitionBoardModelImpl;

  factory _PetitionBoardModel.fromJson(Map<String, dynamic> json) =
      _$PetitionBoardModelImpl.fromJson;

  @override
  List<PetitionPostPreviewModel> get content;
  @override
  bool get hasNext;
  @override
  int get totalPages;
  @override
  int get totalElements;
  @override
  int get page;
  @override
  int get size;
  @override
  bool get first;
  @override
  bool get last;
  @override
  @JsonKey(ignore: true)
  _$$PetitionBoardModelImplCopyWith<_$PetitionBoardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
