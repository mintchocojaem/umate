import 'package:danvery/domain/board/post/general_post/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralPostPageController extends GetxController {
  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();

  final LoginService loginService = Get.find<LoginService>();

  final Rx<GeneralPostModel> generalPostModel = GeneralPostModel().obs;

  final Rx<GeneralCommentListModel> generalCommentList =
      GeneralCommentListModel().obs;

  final RxList<GeneralCommentModel> generalComments =
      <GeneralCommentModel>[].obs;

  final RxBool isLoadedGeneralPost = false.obs;

  final RxBool isLoadedGeneralComment = false.obs;

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
        if (!generalCommentList.value.last) {
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
      if (value.success) {
        generalPostModel.value = value.data as GeneralPostModel;
        isLoadedGeneralPost.value = true;
      }
    });
  }

  Future<void> getGeneralComment(int id) async {
    commentPage = 0;
    await _generalPostRepository
        .getGeneralComment(
            token: loginService.loginModel.accessToken,
            id: id,
            page: commentPage,
            size: commentSize)
        .then((value) {
      if (value.success) {
        generalCommentList.value = value.data as GeneralCommentListModel;
        generalComments.value =
            value.data.generalComments as List<GeneralCommentModel>;
        isLoadedGeneralComment.value = true;
      }
    });
  }

  Future<void> getNextGeneralComment(int id) async {
    commentPage++;
    await _generalPostRepository
        .getGeneralComment(
            token: loginService.loginModel.accessToken,
            id: id,
            page: commentPage,
            size: commentSize)
        .then((value) {
      if (value.success) {
        generalCommentList.value = value.data as GeneralCommentListModel;
        generalComments
            .addAll(value.data.generalComments as List<GeneralCommentModel>);
      }
    });
  }

  Future<void> likePost(int id) async {
    await _generalPostRepository
        .likePost(token: loginService.loginModel.accessToken, id: id)
        .then((value) {
      if (value.success) {
        generalPostModel.value.liked = !generalPostModel.value.liked;
        if (!generalPostModel.value.liked) {
          generalPostModel.value.likes++;
        }
      }else{
        GetXSnackBar(
            type: GetXSnackBarType.customError,
            title: "게시글 좋아요 오류",
            content: value.message)
            .show();
      }
    });
  }

  Future<void> unlikePost(int id) async {
    await _generalPostRepository
        .unlikePost(token: loginService.loginModel.accessToken, id: id)
        .then((value) {
      if (value.success) {
        generalPostModel.value.liked = !generalPostModel.value.liked;
        if (generalPostModel.value.liked) {
          generalPostModel.value.likes--;
        }
      }else{
        GetXSnackBar(
            type: GetXSnackBarType.customError,
            title: "게시글 좋아요 취소 오류",
            content: value.message)
            .show();
      }
    });
  }

}
