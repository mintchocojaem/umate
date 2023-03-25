import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/comment/general_comment/repository/general_comment_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';


class GeneralPostPageController extends GetxController {

  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();
  final GeneralCommentRepository _generalCommentRepository = GeneralCommentRepository();

  final LoginService loginService = Get.find<LoginService>();

  final Rx<GeneralPostModel> _generalPostModel = GeneralPostModel().obs;
  set generalPostModel(value) => _generalPostModel.value = value;
  GeneralPostModel get generalPostModel => _generalPostModel.value;

  final Rx<GeneralCommentListModel> _generalCommentListModel = GeneralCommentListModel().obs;
  set generalCommentListModel(value) => _generalCommentListModel.value = value;
  GeneralCommentListModel get generalCommentListModel => _generalCommentListModel.value;

  final RxBool _isLoadedGeneralPost = false.obs;
  set isLoadedGeneralPost(value) => _isLoadedGeneralPost.value = value;
  bool get isLoadedGeneralPost => _isLoadedGeneralPost.value;

  final RxBool _isLoadedGeneralComment = false.obs;
  set isLoadedGeneralComment(value) => _isLoadedGeneralComment.value = value;
  bool get isLoadedGeneralComment => _isLoadedGeneralComment.value;

  @override
  void onInit() {
    final int id = Get.arguments;
    _generalPostRepository
        .getGeneralPost(loginService.loginModel.accessToken, id)
        .then((value) {
      if (value != null) {
        _generalPostModel.value = value;
        _isLoadedGeneralPost.value = true;
      }
    });
    _generalCommentRepository.getGeneralComment(loginService.loginModel.accessToken, id).then((value) {
      if (value != null) {
        _generalCommentListModel.value = value;
        _generalPostModel.value.commentCount = _generalCommentListModel.value.totalElements;
        _isLoadedGeneralComment.value = true;
      }
    });
    super.onInit();
  }

  Future<bool> createGeneralPost(String token, GeneralPostModel postModel) {
    return _generalPostRepository.createGeneralPost(token, postModel);
  }

}
