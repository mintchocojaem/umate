import 'package:get/get.dart';

import '../model/post_model.dart';
import '../repository/post_repository.dart';


class PostController extends GetxController {

  final PostRepository postRepository;

  PostController({required this.postRepository});

  @override
  void onInit() {
    refreshPostListHome();
    refreshPostListBoard();
    super.onInit();
  }

  final RxList<PostModel> _postListHome = <PostModel>[].obs;
  final RxBool _isLoadPostListHome = false.obs;

  List<PostModel> get postListHome => _postListHome;
  bool get isLoadPostListHome => _isLoadPostListHome.value;

  final RxList<PostModel> _postListBoard = <PostModel>[].obs;
  final RxBool _isLoadPostListBoard = false.obs;

  List<PostModel> get postListBoard => _postListBoard;
  bool get isLoadPostListBoard => _isLoadPostListBoard.value;

  void getPostListHome(int page , int size){
    postRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _postListHome.value = value;
        _isLoadPostListHome.value = true;
      }
    });
  }

  void getPostListBoard(int page , int size){
    postRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _postListBoard.value = value;
        _isLoadPostListBoard.value = true;
      }
    });
  }

  void refreshPostListHome(){
    getPostListHome(0, 5);
  }

  void refreshPostListBoard(){
    getPostListBoard(0, 5);
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
