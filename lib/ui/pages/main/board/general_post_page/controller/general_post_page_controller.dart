import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
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

  final BoardPageController boardPageController = Get.find<BoardPageController>();

  late Rx<GeneralPostModel> generalPost;

  late Rx<GeneralCommentListModel> generalCommentList;

  final RxList<GeneralCommentModel> generalComments =
      <GeneralCommentModel>[].obs;

  final RxBool isLoadedGeneralPost = false.obs;

  final RxBool isLoadedGeneralComment = false.obs;

  final ScrollController generalPostScrollController = ScrollController();

  final TextEditingController commentTextController = TextEditingController();

  late GlobalKey generalPostHeightKey;

  int commentPage = 0;
  final int commentSize = 10;

  final RxBool isLoadedImageList = false.obs;

  @override
  void onInit() async {
    final int id = Get.arguments;

    generalPostScrollController.addListener(() {
      if (generalPostScrollController.position.pixels ==
          generalPostScrollController.position.maxScrollExtent) {
        if (!generalCommentList.value.last) {
          getNextGeneralComment(id);
        }
      }
    });

    await getGeneralPost(id);
    await getFirstGeneralComment(id);

    super.onInit();
  }

  Future<void> getGeneralPost(int id) async {
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.getGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      final GeneralPostModel generalPostModel =
          apiResponseDTO.data as GeneralPostModel;
      generalPost = generalPostModel.obs;
      await getImageList();
      isLoadedGeneralPost.value = true;
    }
  }

  Future<void> deleteGeneralPost(int id) async {
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.deleteGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      await boardPageController.getFirstGeneralPostBoard();
      Get.back();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 삭제 오류").show();
    }
  }

  Future<void> getFirstGeneralComment(int id) async {
    commentPage = 0;
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.getGeneralComment(
            token: loginService.token.value.accessToken,
            commentId: id,
            page: commentPage,
            size: commentSize);
    if (apiResponseDTO.success) {
      final GeneralCommentListModel generalCommentListModel =
          apiResponseDTO.data as GeneralCommentListModel;
      generalCommentList = generalCommentListModel.obs;
      generalComments.value = generalCommentListModel.generalComments;
      isLoadedGeneralComment.value = true;
    }
  }

  Future<void> getNextGeneralComment(int id) async {
    commentPage++;
    final ApiResponseDTO apiResponseDTO = await _generalPostRepository
        .getGeneralComment(
            token: loginService.token.value.accessToken,
            commentId: id,
            page: commentPage,
            size: commentSize);
    if (apiResponseDTO.success) {
      final GeneralCommentListModel generalCommentListModel =
          apiResponseDTO.data as GeneralCommentListModel;
      generalCommentList = generalCommentListModel.obs;
      generalComments
          .addAll(generalCommentListModel.generalComments);
    }
  }

  Future<void> writeGeneralComment(int id) async {
    final ApiResponseDTO apiResponseDTO = await _generalPostRepository
        .writeGeneralComment(
            token: loginService.token.value.accessToken,
            commentId: id,
            text: commentTextController.text);
    if (apiResponseDTO.success) {
      await getFirstGeneralComment(id);
      commentTextController.clear();
      if (generalPostScrollController.position.pixels >=
          generalPostHeightKey.currentContext!.size!.height) {
        generalPostScrollController.animateTo(
            generalPostHeightKey.currentContext!.size!.height,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    }else{
      GetXSnackBar(
          type: GetXSnackBarType.customError,
          content: apiResponseDTO.message,
          title: "댓글 작성 오류")
          .show();
    }
  }

  Future<void> deleteGeneralComment(int id, int commentId) async {
    final ApiResponseDTO apiResponseDTO = await _generalPostRepository
        .deleteGeneralComment(
            token: loginService.token.value.accessToken,
            commentId: commentId);
    if (apiResponseDTO.success) {
      await getFirstGeneralComment(id);
      if (generalPostScrollController.position.pixels >=
          generalPostHeightKey.currentContext!.size!.height) {
        generalPostScrollController.animateTo(
            generalPostHeightKey.currentContext!.size!.height,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    } else {
      GetXSnackBar(
          type: GetXSnackBarType.customError,
          content: apiResponseDTO.message,
          title: "댓글 삭제 오류")
          .show();
    }
  }

  Future<void> likeGeneralPost(int id) async {
    HapticFeedback.heavyImpact();
    final ApiResponseDTO apiResponseDTO = await _generalPostRepository
        .likePost(token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      if (!generalPost.value.liked) {
        generalPost.update((val) async {
          val!.liked = !generalPost.value.liked;
          generalPost.value.likes++;
        });
      } else {
        await unlikeGeneralPost(id);
      }
    } else {
      GetXSnackBar(
          type: GetXSnackBarType.customError,
          content: apiResponseDTO.message,
          title: "게시글 좋아요 오류")
          .show();
    }
  }

  Future<void> unlikeGeneralPost(int id) async{
    final ApiResponseDTO apiResponseDTO = await _generalPostRepository
        .unlikePost(
        token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      generalPost.update((val) async {
        val!.liked = !generalPost.value.liked;
        generalPost.value.likes--;
      });
    }else{
      GetXSnackBar(
          type: GetXSnackBarType.customError,
          content: apiResponseDTO.message,
          title: "게시글 좋아요 오류")
          .show();
    }
  }

  void saveAndGetBack() {
    if (isLoadedGeneralPost.value) {
      generalPost.value.commentCount = generalCommentList.value.totalElements;
      Get.back(result: generalPost.value);
    } else {
      Get.back();
    }
  }

  Future<void> getImageList() async {
    for (FileModel j in generalPost.value.files) {
      final String filePath = (await fileFromImageUrl(j.url, j.originalName ?? "image$j")).path;
      j.url = filePath;
      j.thumbnailUrl = filePath;
    }
    isLoadedImageList.value = true;
  }
}
