import 'package:get/get.dart';

import '../model/general_post_model.dart';
import '../repository/general_post_repository.dart';


class GeneralPostController extends GetxController {

  final GeneralPostRepository generalPostRepository;

  GeneralPostController({required this.generalPostRepository});

  @override
  void onInit() {
    refreshGeneralPostListHome();
    refreshGeneralPostListBoard();
    super.onInit();
  }

  final RxList<GeneralPostModel> _generalPostListHome = <GeneralPostModel>[].obs;
  final RxBool _isLoadGeneralPostListHome = false.obs;

  List<GeneralPostModel> get generalPostListHome => _generalPostListHome;
  bool get isLoadGeneralPostListHome => _isLoadGeneralPostListHome.value;

  final RxList<GeneralPostModel> _generalPostListBoard = <GeneralPostModel>[].obs;
  final RxBool _isLoadGeneralPostListBoard = false.obs;

  List<GeneralPostModel> get generalPostListBoard => _generalPostListBoard;
  bool get isLoadGeneralPostListBoard => _isLoadGeneralPostListBoard.value;

  void getPostListHome(int page , int size){
    generalPostRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _generalPostListHome.value = value;
        _isLoadGeneralPostListHome.value = true;
      }
    });
  }

  void getPostListBoard(int page , int size){
    generalPostRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _generalPostListBoard.value = value;
        _isLoadGeneralPostListBoard.value = true;
      }
    });
  }

  void refreshGeneralPostListHome(){
    getPostListHome(0, 5);
  }

  void refreshGeneralPostListBoard(){
    getPostListBoard(0, 5);
  }

  Future<bool> createGeneralPost(String token, GeneralPostModel postModel) {
    return generalPostRepository.createGeneralPost(token, postModel);
  }

  Future<bool> deleteGeneralPost(String token, int id) {
    return generalPostRepository.deleteGeneralPost(token, id);
  }

  Future<GeneralPostModel?> getGeneralPost(String token, int id) {
    return generalPostRepository.getGeneralPost(token, id);
  }

}
