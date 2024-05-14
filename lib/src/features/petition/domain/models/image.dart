import 'file.dart';

class PostImage extends PostFile {
  final String thumbnailUrl;

  PostImage({
    required super.id,
    required super.url,
    required super.name,
    required super.mimeType,
    required this.thumbnailUrl,
  });
}
