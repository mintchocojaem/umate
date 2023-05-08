import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_list_model.dart';
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

  final BoardPageController boardPageController =
      Get.find<BoardPageController>();

  late Rx<GeneralPostModel> generalPost;

  late Rx<GeneralCommentListModel> generalCommentList;

  final RxBool isLoadedGeneralPost = false.obs;

  final RxBool isLoadedGeneralComment = false.obs;

  final ScrollController generalPostScrollController = ScrollController();

  final TextEditingController commentTextController = TextEditingController();

  late GlobalKey generalPostHeightKey;

  int commentPage = 0;
  final int commentSize = 10;

  final RxBool isLoadedImageList = false.obs;

  final int id = Get.arguments;

  bool isRefreshingComment = false;

  @override
  void onInit() async {
    generalPostScrollController.addListener(() async {
      if (generalPostScrollController.position.pixels ==
          generalPostScrollController.position.maxScrollExtent) {
        if (!generalCommentList.value.last) {
          await getGeneralCommentWithRefresh(false);
        }
      }
    });

    await getGeneralPost();
    await getGeneralCommentWithRefresh(true);

    super.onInit();
  }

  Future<void> getGeneralPost() async {
    isLoadedGeneralPost.value = false;
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.getGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      final GeneralPostModel generalPostModel =
          apiResponseDTO.data as GeneralPostModel;
      generalPost = generalPostModel.obs;
      await getImageList();
      isLoadedGeneralPost.value = true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 조회 오류")
          .show();
    }
  }

  Future<void> deleteGeneralPost() async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
      barrierDismissible: false,
    ).whenComplete(() => Get.back());

    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.deleteGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      await boardPageController.getGeneralPostBoardWithRefresh(true);
      Get.back();
      Get.back();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 삭제 오류")
          .show();
    }
  }

  Future<void> getGeneralCommentWithRefresh(bool isFirstPage) async {
    if (!isRefreshingComment) {
      await _getGeneralComment(isFirstPage);
    }
  }

  Future<void> _getGeneralComment(bool isFirstPage) async {
    isRefreshingComment = true;
    if (isFirstPage) {
      commentPage = 0;
    } else {
      commentPage++;
    }
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.getGeneralComment(
            token: loginService.token.value.accessToken,
            commentId: id,
            page: commentPage,
            size: commentSize);
    if (apiResponseDTO.success) {
      final generalCommentListModel =
          apiResponseDTO.data as GeneralCommentListModel;
      if (isFirstPage) {
        try {
          generalCommentList.update((val) {
            generalCommentList = generalCommentListModel.obs;
          });
        } catch (e) {
          generalCommentList = generalCommentListModel.obs;
        }
      } else {
        generalCommentList.update((val) {
          if (val != null) {
            val.generalComments.addAll(generalCommentListModel.generalComments);
            val.last = generalCommentListModel.last;
          }
        });
      }
      isLoadedGeneralComment.value = true;
    } else {
      if (!isFirstPage) {
        commentPage--;
      }
      Future.delayed(const Duration(seconds: 10), () async {
        await _getGeneralComment(isFirstPage);
      });
    }
    isRefreshingComment = false;
  }

  Future<void> writeGeneralComment() async {
    FocusManager.instance.primaryFocus?.unfocus();

    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
      barrierDismissible: false,
    );

    if (commentTextController.text.isEmpty) {
      return;
    }

    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.writeGeneralComment(
            token: loginService.token.value.accessToken,
            commentId: id,
            text: commentTextController.text);
    if (apiResponseDTO.success) {
      await getGeneralCommentWithRefresh(true);
      Get.back();
      commentTextController.clear();
      if (generalPostScrollController.position.pixels >=
          generalPostHeightKey.currentContext!.size!.height) {
        generalPostScrollController.animateTo(
            generalPostHeightKey.currentContext!.size!.height,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut);
      }
    } else {
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "댓글 작성 오류")
          .show();
    }
  }

  Future<void> deleteGeneralComment(int commentId) async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
      barrierDismissible: false,
    ).whenComplete(() => Get.back());

    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.deleteGeneralComment(
            token: loginService.token.value.accessToken, commentId: commentId);
    if (apiResponseDTO.success) {
      await getGeneralCommentWithRefresh(true);
      Get.back();
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

  Future<void> likeGeneralPost() async {
    HapticFeedback.heavyImpact();
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.likeGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      if (!generalPost.value.liked) {
        generalPost.update((val) async {
          val!.liked = !generalPost.value.liked;
          generalPost.value.likes++;
        });
      } else {
        await unlikeGeneralPost();
      }
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 좋아요 오류")
          .show();
    }
  }

  Future<void> unlikeGeneralPost() async {
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.unlikeGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      generalPost.update((val) async {
        val!.liked = !generalPost.value.liked;
        generalPost.value.likes--;
      });
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 좋아요 오류")
          .show();
    }
  }

  Future<void> reportGeneralPost(String category) async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
      barrierDismissible: false,
    );
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.reportGeneralPost(
            token: loginService.token.value.accessToken,
            postId: id,
            categoryName: category);
    if (apiResponseDTO.success) {
      Get.back();
      GetXSnackBar(
        type: GetXSnackBarType.info,
        title: "게시글 신고",
        content: "신고가 접수되었습니다. 검토까지는 최대 24시간이 소요됩니다.",
      ).show();
    } else {
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "신고 오류")
          .show();
    }
  }

  Future<void> blindGeneralPost() async {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
      barrierDismissible: false,
    ).whenComplete(() => Get.back());
    final ApiResponseDTO apiResponseDTO =
        await _generalPostRepository.blindGeneralPost(
            token: loginService.token.value.accessToken, postId: id);
    if (apiResponseDTO.success) {
      await boardPageController.getGeneralPostBoardWithRefresh(true);
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              content: "게시글이 정상적으로 블라인드 처리되었습니다",
              title: "게시글 블라인드")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              content: apiResponseDTO.message,
              title: "게시글 블라인드 오류")
          .show();
    }
  }

  void saveAndGetBack() {
    if (isLoadedGeneralPost.value && isLoadedGeneralComment.value) {
      generalPost.value.commentCount = generalCommentList.value.totalElements;
      Get.back(result: generalPost.value);
    } else {
      Get.back();
    }
  }

  Future<void> getImageList() async {
    for (FileModel j in generalPost.value.files) {
      if (j.mimeType.contains('image')) {
        final String filePath =
            (await fileFromImageUrl(j.url, j.originalName ?? "image$j")).path;
        j.url = filePath;
        j.thumbnailUrl = filePath;
      }
    }
    isLoadedImageList.value = true;
  }
}
