import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:get/get.dart';

import '../repository/general_post_repository.dart';


class GeneralPostController extends GetxController {

  final GeneralPostRepository generalPostRepository;

  GeneralPostController({required this.generalPostRepository});

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<GeneralPostModel>?> getGeneralPostListHome(int page , int size) async{
    return generalPostRepository.getGeneralBoard(page, size);
  }

  Future<List<GeneralPostModel>?> getGeneralPostListBoard(int page , int size) async{
    return generalPostRepository.getGeneralBoard(page, size);
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
