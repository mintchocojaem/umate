import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/post.dart';
import 'post_file_dto.dart';
import 'post_image_dto.dart';

abstract class PostDTO extends DataMapper<Post> {
  final int id;
  final String title;
  final String author;
  final String body;
  final String createdAt;
  final List<PostFileDTO> files;
  final List<PostImageDTO> images;

  //images
  final int views;
  final bool mine;
  final bool blinded;

  PostDTO({
    required this.id,
    required this.title,
    this.author = '익명',
    required this.body,
    required this.createdAt,
    this.files = const [],
    this.images = const [],
    this.views = 0,
    this.mine = false,
    this.blinded = false,
  });
}
