import 'post_file.dart';
import 'post_image.dart';

abstract class Post {
  final int id;
  final String title;
  final String author;
  final String body;
  final String createdAt;
  final List<PostFile> files;
  final List<PostImage> images;
  final int views;
  final bool mine;
  final bool blinded;

  Post({
    required this.id,
    required this.title,
    required this.author,
    this.body = '',
    required this.createdAt,
    this.files = const [],
    this.images = const [],
    this.views = 0,
    this.mine = false,
    this.blinded = false,
  });
}
