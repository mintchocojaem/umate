import 'package:get/get.dart';

import '../../post/model/post_model.dart';
import '../../post/repository/post_repository.dart';


class PostController extends GetxController {

  final PostRepository postRepository;

  PostController({required this.postRepository});

  @override
  void onInit() {
    refreshGeneralBoard();
    super.onInit();
  }

  final RxList<PostModel> _generalBoard = <PostModel>[].obs;
  final RxBool _isLoadGeneralBoard = false.obs;

  List<PostModel> get generalBoard => _generalBoard;
  bool get isLoadGeneralBoard => _isLoadGeneralBoard.value;

  void getGeneralBoard(int page , int size){
    postRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _generalBoard.value = value;
        _isLoadGeneralBoard.value = true;
      }
    });
  }

  void refreshGeneralBoard(){
    getGeneralBoard(0, 5);
  }

  Future<bool> createPost(String token, PostModel postModel) {
    return postRepository.createPost(token, postModel);
  }

  Future<bool> deletePost(String token, int id) {
    return postRepository.deletePost(token, id);
  }

  Future<PostModel?> getPost(String token, int id) {
    return postRepository.getPost(token, id);
  }

}
