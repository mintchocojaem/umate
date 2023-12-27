// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'petition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Agree _$AgreeFromJson(Map<String, dynamic> json) {
  return _Agree.fromJson(json);
}

/// @nodoc
mixin _$Agree {
  String get department => throw _privateConstructorUsedError;
  int get agreeCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgreeCopyWith<Agree> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgreeCopyWith<$Res> {
  factory $AgreeCopyWith(Agree value, $Res Function(Agree) then) =
      _$AgreeCopyWithImpl<$Res, Agree>;
  @useResult
  $Res call({String department, int agreeCount});
}

/// @nodoc
class _$AgreeCopyWithImpl<$Res, $Val extends Agree>
    implements $AgreeCopyWith<$Res> {
  _$AgreeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? department = null,
    Object? agreeCount = null,
  }) {
    return _then(_value.copyWith(
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgreeImplCopyWith<$Res> implements $AgreeCopyWith<$Res> {
  factory _$$AgreeImplCopyWith(
          _$AgreeImpl value, $Res Function(_$AgreeImpl) then) =
      __$$AgreeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String department, int agreeCount});
}

/// @nodoc
class __$$AgreeImplCopyWithImpl<$Res>
    extends _$AgreeCopyWithImpl<$Res, _$AgreeImpl>
    implements _$$AgreeImplCopyWith<$Res> {
  __$$AgreeImplCopyWithImpl(
      _$AgreeImpl _value, $Res Function(_$AgreeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? department = null,
    Object? agreeCount = null,
  }) {
    return _then(_$AgreeImpl(
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgreeImpl implements _Agree {
  const _$AgreeImpl({required this.department, required this.agreeCount});

  factory _$AgreeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgreeImplFromJson(json);

  @override
  final String department;
  @override
  final int agreeCount;

  @override
  String toString() {
    return 'Agree(department: $department, agreeCount: $agreeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgreeImpl &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.agreeCount, agreeCount) ||
                other.agreeCount == agreeCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, department, agreeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgreeImplCopyWith<_$AgreeImpl> get copyWith =>
      __$$AgreeImplCopyWithImpl<_$AgreeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgreeImplToJson(
      this,
    );
  }
}

abstract class _Agree implements Agree {
  const factory _Agree(
      {required final String department,
      required final int agreeCount}) = _$AgreeImpl;

  factory _Agree.fromJson(Map<String, dynamic> json) = _$AgreeImpl.fromJson;

  @override
  String get department;
  @override
  int get agreeCount;
  @override
  @JsonKey(ignore: true)
  _$$AgreeImplCopyWith<_$AgreeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

File _$FileFromJson(Map<String, dynamic> json) {
  return _File.fromJson(json);
}

/// @nodoc
mixin _$File {
  int get id => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  String get originalName => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileCopyWith<File> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileCopyWith<$Res> {
  factory $FileCopyWith(File value, $Res Function(File) then) =
      _$FileCopyWithImpl<$Res, File>;
  @useResult
  $Res call(
      {int id,
      String url,
      String thumbnailUrl,
      String originalName,
      String mimeType});
}

/// @nodoc
class _$FileCopyWithImpl<$Res, $Val extends File>
    implements $FileCopyWith<$Res> {
  _$FileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? thumbnailUrl = null,
    Object? originalName = null,
    Object? mimeType = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      originalName: null == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FileImplCopyWith<$Res> implements $FileCopyWith<$Res> {
  factory _$$FileImplCopyWith(
          _$FileImpl value, $Res Function(_$FileImpl) then) =
      __$$FileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String url,
      String thumbnailUrl,
      String originalName,
      String mimeType});
}

/// @nodoc
class __$$FileImplCopyWithImpl<$Res>
    extends _$FileCopyWithImpl<$Res, _$FileImpl>
    implements _$$FileImplCopyWith<$Res> {
  __$$FileImplCopyWithImpl(_$FileImpl _value, $Res Function(_$FileImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? thumbnailUrl = null,
    Object? originalName = null,
    Object? mimeType = null,
  }) {
    return _then(_$FileImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      originalName: null == originalName
          ? _value.originalName
          : originalName // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FileImpl implements _File {
  const _$FileImpl(
      {required this.id,
      required this.url,
      required this.thumbnailUrl,
      required this.originalName,
      required this.mimeType});

  factory _$FileImpl.fromJson(Map<String, dynamic> json) =>
      _$$FileImplFromJson(json);

  @override
  final int id;
  @override
  final String url;
  @override
  final String thumbnailUrl;
  @override
  final String originalName;
  @override
  final String mimeType;

  @override
  String toString() {
    return 'File(id: $id, url: $url, thumbnailUrl: $thumbnailUrl, originalName: $originalName, mimeType: $mimeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.originalName, originalName) ||
                other.originalName == originalName) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, url, thumbnailUrl, originalName, mimeType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FileImplCopyWith<_$FileImpl> get copyWith =>
      __$$FileImplCopyWithImpl<_$FileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FileImplToJson(
      this,
    );
  }
}

abstract class _File implements File {
  const factory _File(
      {required final int id,
      required final String url,
      required final String thumbnailUrl,
      required final String originalName,
      required final String mimeType}) = _$FileImpl;

  factory _File.fromJson(Map<String, dynamic> json) = _$FileImpl.fromJson;

  @override
  int get id;
  @override
  String get url;
  @override
  String get thumbnailUrl;
  @override
  String get originalName;
  @override
  String get mimeType;
  @override
  @JsonKey(ignore: true)
  _$$FileImplCopyWith<_$FileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Petition _$PetitionFromJson(Map<String, dynamic> json) {
  return _Petition.fromJson(json);
}

/// @nodoc
mixin _$Petition {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  List<File?> get files => throw _privateConstructorUsedError;
  PetitionStatus get status => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  int get agreeCount => throw _privateConstructorUsedError;
  List<Agree?>? get statisticList => throw _privateConstructorUsedError;
  bool get agree => throw _privateConstructorUsedError;
  bool get mine => throw _privateConstructorUsedError;
  bool get blinded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetitionCopyWith<Petition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetitionCopyWith<$Res> {
  factory $PetitionCopyWith(Petition value, $Res Function(Petition) then) =
      _$PetitionCopyWithImpl<$Res, Petition>;
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String body,
      String? answer,
      String createdAt,
      List<File?> files,
      PetitionStatus status,
      String expiresAt,
      int agreeCount,
      List<Agree?>? statisticList,
      bool agree,
      bool mine,
      bool blinded});
}

/// @nodoc
class _$PetitionCopyWithImpl<$Res, $Val extends Petition>
    implements $PetitionCopyWith<$Res> {
  _$PetitionCopyWithImpl(this._value, this._then);

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
    Object? files = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? agreeCount = null,
    Object? statisticList = freezed,
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
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File?>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PetitionStatus,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      statisticList: freezed == statisticList
          ? _value.statisticList
          : statisticList // ignore: cast_nullable_to_non_nullable
              as List<Agree?>?,
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
abstract class _$$PetitionImplCopyWith<$Res>
    implements $PetitionCopyWith<$Res> {
  factory _$$PetitionImplCopyWith(
          _$PetitionImpl value, $Res Function(_$PetitionImpl) then) =
      __$$PetitionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String body,
      String? answer,
      String createdAt,
      List<File?> files,
      PetitionStatus status,
      String expiresAt,
      int agreeCount,
      List<Agree?>? statisticList,
      bool agree,
      bool mine,
      bool blinded});
}

/// @nodoc
class __$$PetitionImplCopyWithImpl<$Res>
    extends _$PetitionCopyWithImpl<$Res, _$PetitionImpl>
    implements _$$PetitionImplCopyWith<$Res> {
  __$$PetitionImplCopyWithImpl(
      _$PetitionImpl _value, $Res Function(_$PetitionImpl) _then)
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
    Object? files = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? agreeCount = null,
    Object? statisticList = freezed,
    Object? agree = null,
    Object? mine = null,
    Object? blinded = null,
  }) {
    return _then(_$PetitionImpl(
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
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<File?>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PetitionStatus,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      statisticList: freezed == statisticList
          ? _value._statisticList
          : statisticList // ignore: cast_nullable_to_non_nullable
              as List<Agree?>?,
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
class _$PetitionImpl implements _Petition {
  const _$PetitionImpl(
      {required this.id,
      required this.title,
      required this.author,
      required this.body,
      this.answer,
      required this.createdAt,
      required final List<File?> files,
      required this.status,
      required this.expiresAt,
      required this.agreeCount,
      final List<Agree?>? statisticList,
      this.agree = false,
      this.mine = false,
      required this.blinded})
      : _files = files,
        _statisticList = statisticList;

  factory _$PetitionImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetitionImplFromJson(json);

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
  final List<File?> _files;
  @override
  List<File?> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @override
  final PetitionStatus status;
  @override
  final String expiresAt;
  @override
  final int agreeCount;
  final List<Agree?>? _statisticList;
  @override
  List<Agree?>? get statisticList {
    final value = _statisticList;
    if (value == null) return null;
    if (_statisticList is EqualUnmodifiableListView) return _statisticList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final bool agree;
  @override
  @JsonKey()
  final bool mine;
  @override
  final bool blinded;

  @override
  String toString() {
    return 'Petition(id: $id, title: $title, author: $author, body: $body, answer: $answer, createdAt: $createdAt, files: $files, status: $status, expiresAt: $expiresAt, agreeCount: $agreeCount, statisticList: $statisticList, agree: $agree, mine: $mine, blinded: $blinded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetitionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._files, _files) &&
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
      const DeepCollectionEquality().hash(_files),
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
  _$$PetitionImplCopyWith<_$PetitionImpl> get copyWith =>
      __$$PetitionImplCopyWithImpl<_$PetitionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetitionImplToJson(
      this,
    );
  }
}

abstract class _Petition implements Petition {
  const factory _Petition(
      {required final int id,
      required final String title,
      required final String author,
      required final String body,
      final String? answer,
      required final String createdAt,
      required final List<File?> files,
      required final PetitionStatus status,
      required final String expiresAt,
      required final int agreeCount,
      final List<Agree?>? statisticList,
      final bool agree,
      final bool mine,
      required final bool blinded}) = _$PetitionImpl;

  factory _Petition.fromJson(Map<String, dynamic> json) =
      _$PetitionImpl.fromJson;

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
  @override
  List<File?> get files;
  @override
  PetitionStatus get status;
  @override
  String get expiresAt;
  @override
  int get agreeCount;
  @override
  List<Agree?>? get statisticList;
  @override
  bool get agree;
  @override
  bool get mine;
  @override
  bool get blinded;
  @override
  @JsonKey(ignore: true)
  _$$PetitionImplCopyWith<_$PetitionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
