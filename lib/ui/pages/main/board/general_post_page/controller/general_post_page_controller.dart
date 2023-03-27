import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/comment/general_comment/model/general_comment_model.dart';
import 'package:danvery/domain/board/comment/general_comment/repository/general_comment_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralPostPageController extends GetxController {
  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();
  final GeneralCommentRepository _generalCommentRepository =
      GeneralCommentRepository();

  final LoginService loginService = Get.find<LoginService>();

  final Rx<GeneralPostModel> _generalPostModel = GeneralPostModel().obs;

  GeneralPostModel get generalPostModel => _generalPostModel.value;

  final Rx<GeneralCommentListModel> _generalCommentListModel =
      GeneralCommentListModel().obs;

  GeneralCommentListModel get generalCommentListModel =>
      _generalCommentListModel.value;

  final RxList<GeneralCommentModel> _generalCommentList =
      <GeneralCommentModel>[].obs;

  List<GeneralCommentModel> get generalCommentList => _generalCommentList;

  final RxBool _isLoadedGeneralPost = false.obs;

  bool get isLoadedGeneralPost => _isLoadedGeneralPost.value;

  final RxBool _isLoadedGeneralComment = false.obs;

  bool get isLoadedGeneralComment => _isLoadedGeneralComment.value;

  final ScrollController generalCommentScrollController = ScrollController();

  int commentPage = 0;
  final int commentSize = 5;

  @override
  void onInit() {
    final int id = Get.arguments;
    getGeneralPost(id);
    getGeneralComment(id);

    generalCommentScrollController.addListener(() {
      if (generalCommentScrollController.position.pixels ==
          generalCommentScrollController.position.maxScrollExtent) {
        if(!generalCommentListModel.last){
          getNextGeneralComment(id);
        }
      }
    });

    super.onInit();
  }

  Future<void> getGeneralPost(int id) async {
    await _generalPostRepository
        .getGeneralPost(token: loginService.loginModel.accessToken, id: id)
        .then((value) {
      if (value != null) {
        _generalPostModel.value = value;
        _isLoadedGeneralPost.value = true;
      }
    });
  }

  Future<void> getGeneralComment(int id) async {
    commentPage = 0;
    await _generalCommentRepository
        .getGeneralComment(
            token: loginService.loginModel.accessToken,
            id: id,
            page: commentPage,
            size: commentSize)
        .then((value) {
      if (value != null) {
        _generalCommentListModel.value = value;
        _generalCommentList.value = value.generalCommentList;
        _isLoadedGeneralComment.value = true;
      }
    });
  }

  Future<void> getNextGeneralComment(int id) async {
    commentPage++;
    await _generalCommentRepository
        .getGeneralComment(
            token: loginService.loginModel.accessToken,
            id: id,
            page: commentPage,
            size: commentSize)
        .then((value) {
      if (value != null) {
        _generalCommentListModel.value = value;
        _generalCommentList.addAll(value.generalCommentList);
      }
    });
  }

}
