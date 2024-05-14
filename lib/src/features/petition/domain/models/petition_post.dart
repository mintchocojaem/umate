import 'petition_status.dart';
import 'post.dart';

class PetitionPost extends Post {
  final String? answer;

  //files
  //images
  final PetitionStatus status;
  final String expiresAt;
  final int agreeCount;

  //statistics
  final bool agree;

  PetitionPost({
    required super.id,
    required super.title,
    required super.author,
    required super.body,
    required super.createdAt,
    required super.files,
    required super.images,
    required super.views,
    required super.mine,
    required super.blinded,
    this.answer,
    required this.status,
    required this.expiresAt,
    required this.agreeCount,
    required this.agree,
  });

  copyWith({
    bool? agree,
    int? agreeCount,
  }) {
    return PetitionPost(
      id: id,
      title: title,
      author: author,
      body: body,
      createdAt: createdAt,
      files: files,
      images: images,
      views: views,
      mine: mine,
      blinded: blinded,
      answer: answer,
      status: status,
      expiresAt: expiresAt,
      agreeCount: agreeCount ?? this.agreeCount,
      agree: agree ?? this.agree,
    );
  }
}
