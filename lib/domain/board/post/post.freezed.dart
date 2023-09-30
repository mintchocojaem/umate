// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

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
abstract class _$$_FileCopyWith<$Res> implements $FileCopyWith<$Res> {
  factory _$$_FileCopyWith(_$_File value, $Res Function(_$_File) then) =
      __$$_FileCopyWithImpl<$Res>;
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
class __$$_FileCopyWithImpl<$Res> extends _$FileCopyWithImpl<$Res, _$_File>
    implements _$$_FileCopyWith<$Res> {
  __$$_FileCopyWithImpl(_$_File _value, $Res Function(_$_File) _then)
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
    return _then(_$_File(
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
class _$_File implements _File {
  const _$_File(
      {required this.id,
      required this.url,
      required this.thumbnailUrl,
      required this.originalName,
      required this.mimeType});

  factory _$_File.fromJson(Map<String, dynamic> json) => _$$_FileFromJson(json);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_File &&
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
  _$$_FileCopyWith<_$_File> get copyWith =>
      __$$_FileCopyWithImpl<_$_File>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileToJson(
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
      required final String mimeType}) = _$_File;

  factory _File.fromJson(Map<String, dynamic> json) = _$_File.fromJson;

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
  _$$_FileCopyWith<_$_File> get copyWith => throw _privateConstructorUsedError;
}

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String? get answer => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  List<File?> get files => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  int get agreeCount => throw _privateConstructorUsedError;
  bool get blinded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String body,
      String? answer,
      String createdAt,
      List<File?> files,
      String status,
      String expiresAt,
      int agreeCount,
      bool blinded});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

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
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      blinded: null == blinded
          ? _value.blinded
          : blinded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$_PostCopyWith(_$_Post value, $Res Function(_$_Post) then) =
      __$$_PostCopyWithImpl<$Res>;
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
      String status,
      String expiresAt,
      int agreeCount,
      bool blinded});
}

/// @nodoc
class __$$_PostCopyWithImpl<$Res> extends _$PostCopyWithImpl<$Res, _$_Post>
    implements _$$_PostCopyWith<$Res> {
  __$$_PostCopyWithImpl(_$_Post _value, $Res Function(_$_Post) _then)
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
    Object? blinded = null,
  }) {
    return _then(_$_Post(
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
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      blinded: null == blinded
          ? _value.blinded
          : blinded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Post implements _Post {
  const _$_Post(
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
      required this.blinded})
      : _files = files;

  factory _$_Post.fromJson(Map<String, dynamic> json) => _$$_PostFromJson(json);

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
  final String status;
  @override
  final String expiresAt;
  @override
  final int agreeCount;
  @override
  final bool blinded;

  @override
  String toString() {
    return 'Post(id: $id, title: $title, author: $author, body: $body, answer: $answer, createdAt: $createdAt, files: $files, status: $status, expiresAt: $expiresAt, agreeCount: $agreeCount, blinded: $blinded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Post &&
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
      blinded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostCopyWith<_$_Post> get copyWith =>
      __$$_PostCopyWithImpl<_$_Post>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {required final int id,
      required final String title,
      required final String author,
      required final String body,
      final String? answer,
      required final String createdAt,
      required final List<File?> files,
      required final String status,
      required final String expiresAt,
      required final int agreeCount,
      required final bool blinded}) = _$_Post;

  factory _Post.fromJson(Map<String, dynamic> json) = _$_Post.fromJson;

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
  String get status;
  @override
  String get expiresAt;
  @override
  int get agreeCount;
  @override
  bool get blinded;
  @override
  @JsonKey(ignore: true)
  _$$_PostCopyWith<_$_Post> get copyWith => throw _privateConstructorUsedError;
}
