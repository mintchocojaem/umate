import 'package:danvery/domain/board/post/general_post/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

  final ScrollController generalPostScrollController = ScrollController();

  final BoardPageController boardPageController =
      Get.find<BoardPageController>();

  final TextEditingController commentTextController = TextEditingController();

  late GlobalKey generalPostHeightKey;

  int commentPage = 0;
  final int commentSize = 10;

  @override
  void onInit() {
    final int id = Get.arguments;
    getGeneralPost(id);
    getFirstGeneralComment(id);

    generalPostScrollController.addListener(() {
      if (generalPostScrollController.position.pixels ==
          generalPostScrollController.position.maxScrollExtent) {
        if (!generalCommentList.value.last) {
          getNextGeneralComment(id);
        }
      }
    });

    super.onInit();
  }

  Future<void> getGeneralPost(int id) async {
    await _generalPostRepository
        .getGeneralPost(token: loginService.loginModel.accessToken, postId: id)
        .then((value) {
      if (value.success) {
        generalPostModel.value = value.data as GeneralPostModel;
        generalPostModel.value.createdAt = generalPostModel.value.createdAt
            .substring(0, generalPostModel.value.createdAt.length - 9);
        //여기 나중에 날짜 보드 뷰랑 포스트 뷰랑 통일 시켜야 함
        isLoadedGeneralPost.value = true;
      }
    });
  }

  Future<void> deleteGeneralPost(int id) async {
    await _generalPostRepository
        .deleteGeneralPost(token: loginService.loginModel.accessToken, postId: id)
        .then((value) async {
      if (value.success) {
        await boardPageController.getFirstGeneralPostBoard().then((value) {
          Get.back();
        });
      } else {
        GetXSnackBar(
                type: GetXSnackBarType.customError,
                content: value.message,
                title: "게시글 삭제 오류")
            .show();
      }
    });
  }

  Future<void> getFirstGeneralComment(int id) async {
    commentPage = 0;
    await _generalPostRepository
        .getGeneralComment(
            token: loginService.loginModel.accessToken,
            commentId: id,
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
            commentId: id,
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

  Future<void> writeGeneralComment(int id) async {
    await _generalPostRepository
        .writeGeneralComment(
            token: loginService.loginModel.accessToken,
            commentId: id,
            text: commentTextController.text)
        .then((value) async {
      if (value.success) {
        await getFirstGeneralComment(id).then((value) {
          commentTextController.clear();
          if(generalPostScrollController.position.pixels >=
              generalPostHeightKey.currentContext!.size!.height){
            generalPostScrollController.animateTo(
                generalPostHeightKey.currentContext!.size!.height,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        });
      } else {
        GetXSnackBar(
                type: GetXSnackBarType.customError,
                content: value.message,
                title: "댓글 작성 오류")
            .show();
      }
    });
  }

  Future<void> deleteGeneralComment(int id, int commentId) async {
    await _generalPostRepository
        .deleteGeneralComment(
            token: loginService.loginModel.accessToken, commentId: commentId)
        .then((value) async {
      if (value.success) {
        await getFirstGeneralComment(id).then((value) {
          if(generalPostScrollController.position.pixels >=
              generalPostHeightKey.currentContext!.size!.height){
            generalPostScrollController.animateTo(
                generalPostHeightKey.currentContext!.size!.height,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut);
          }
        });
      } else {
        GetXSnackBar(
                type: GetXSnackBarType.customError,
                content: value.message,
                title: "댓글 삭제 오류")
            .show();
      }
    });
  }

  Future<void> likeGeneralPost(int id) async {
    HapticFeedback.heavyImpact();
    await _generalPostRepository
        .likePost(token: loginService.loginModel.accessToken, postId: id)
        .then((value) async {
      if (value.success) {
        if (!generalPostModel.value.liked) {
          generalPostModel.update((val) async {
            val!.liked = !generalPostModel.value.liked;
            generalPostModel.value.likes++;
          });
        } else {
          await _generalPostRepository
              .unlikePost(
                  token: loginService.loginModel.accessToken, postId: id)
              .then((value) {
            if (value.success) {
              generalPostModel.update((val) async {
                val!.liked = !generalPostModel.value.liked;
                generalPostModel.value.likes--;
              });
            }
          });
        }
      } else {
        GetXSnackBar(
                type: GetXSnackBarType.customError,
                content: value.message,
                title: "게시글 좋아요 오류")
            .show();
      }
    });
  }

  void saveAndGetBack() {
    if (isLoadedGeneralPost.value) {
      generalPostModel.value.commentCount =
          generalCommentList.value.totalElements;
      Get.back(result: generalPostModel.value);
    } else {
      Get.back();
    }
  }
}
