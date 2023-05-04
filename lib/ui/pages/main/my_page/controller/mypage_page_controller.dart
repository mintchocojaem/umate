import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/user/info/model/user_post_list_model.dart';
import 'package:danvery/domain/user/info/model/user_post_model.dart';
import 'package:danvery/domain/user/info/repository/userInfo_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/service/permission/permission_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum MyPagePostType { write, comment, like }

extension MyPagePostTypeExtension on MyPagePostType {
  String get title {
    switch (this) {
      case MyPagePostType.write:
        return "내가 게시한 글";
      case MyPagePostType.comment:
        return "내가 댓글 단 글";
      case MyPagePostType.like:
        return "내가 좋아요한 글";
    }
  }
}

class MyPagePageController extends GetxController {
  final PermissionService permissionService = Get.find<PermissionService>();
  final LoginService loginService = Get.find<LoginService>();
  final UserInfoRepository _userInfoRepository = UserInfoRepository();

  Rx<TextEditingController> nickname = TextEditingController().obs;
  Rx<TextEditingController> currentPassword = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> passwordValidate = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> phoneAuthenticationNumber = TextEditingController().obs;

  late Rx<UserPostListModel> userPostList;

  int _page = 0;
  int size = 10;

  MyPagePostType myPagePostType = MyPagePostType.write;

  final ScrollController scrollController = ScrollController();

  final RxBool isLoadPost = false.obs;

  bool isRefreshing = false;

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!userPostList.value.last) {
          await getUserPostListWithRefresh(false);
        }
      }
    });
    super.onInit();
  }

  void initEditPage(){
    nickname.value.text = loginService.userInfo.value.nickname;
    currentPassword.value.clear();
    password.value.clear();
    passwordValidate.value.clear();
    phoneNumber.value.clear();
    phoneAuthenticationNumber.value.clear();
}

  late String changePhoneNumberToken;

  Future<void> changeNickname() async {
    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.changeNickname(
            accessToken: loginService.token.value.accessToken,
            nickName: nickname.value.text);
    if (apiResponseDTO.success) {
      loginService.userInfo.update((val) {
        val!.nickname = nickname.value.text;
      });
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "닉네임 변경 성공",
              content: "닉네임이 변경되었습니다.")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "닉네임 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

  Future<bool> verifySMS() async {
    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.verifySMS(
        phoneNumber: phoneNumber.value.text,
        accessToken: loginService.token.value.accessToken);
    if (apiResponseDTO.success) {
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "인증번호 전송 성공",
              content: "인증번호가 전송되었습니다. 휴대폰을 확인해주세요")
          .show();
      changePhoneNumberToken = apiResponseDTO.data['token'] as String;
      return true;
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "인증번호 전송 오류",
              content: apiResponseDTO.message)
          .show();
      return false;
    }
  }

  Future<void> changePhoneNumber() async {
    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.changePhoneNumber(
      accessToken: loginService.token.value.accessToken,
      token: changePhoneNumberToken,
      code: phoneAuthenticationNumber.value.text,
    );
    if (apiResponseDTO.success) {
      Get.back();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "휴대폰 번호 변경 성공",
              content: "휴대폰 번호가 변경되었습니다.")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "휴대폰 번호 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

  Future<void> changePassword() async{
    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.changePassword(
      accessToken: loginService.token.value.accessToken,
      currentPassword: currentPassword.value.text,
      newPassword: password.value.text,
    );
    if(apiResponseDTO.success){
      await loginService.logout();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "비밀번호 변경 성공",
              content: "비밀번호가 변경되었습니다.")
          .show();
    }else{
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "비밀번호 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

  Future<void> getUserPostListWithRefresh(bool isFirstPage) async{
    if(!isRefreshing){
      switch(myPagePostType){
        case MyPagePostType.write:
          await _getUserWritePostList(isFirstPage);
          break;
        case MyPagePostType.comment:
          await _getUserCommentedPostList(isFirstPage);
          break;
        case MyPagePostType.like:
          await _getUserLikedPostList(isFirstPage);
          break;
      }
    }
  }

  Future<void> _getUserWritePostList(bool isFirstPage) async {

    isRefreshing = true;

    if(isFirstPage){
      isLoadPost.value = false;
      _page = 0;
    }else{
      _page ++;
    }

    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.getUserWritePostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final UserPostListModel userPostListModel = apiResponseDTO.data as UserPostListModel;

      await getThumbnailList(userPostListModel.userPosts);

      if (isFirstPage) {
        userPostList = userPostListModel.obs;
      } else {
        userPostList.update((val) {
          val!.userPosts.addAll(userPostListModel.userPosts);
          val.last = userPostListModel.last;
        });
      }

      isLoadPost.value = true;
    } else {
      isLoadPost.value = false;

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserWritePostList(isFirstPage);
      });
    }

    isRefreshing = false;
  }

  Future<void> _getUserCommentedPostList(bool isFirstPage) async {

    isRefreshing = true;

    if(isFirstPage){
      isLoadPost.value = false;
      _page = 0;
    }else{
      _page++;
    }

    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.getUserCommentedPostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final UserPostListModel userPostListModel = apiResponseDTO.data as UserPostListModel;

      await getThumbnailList(userPostListModel.userPosts);

      if (isFirstPage) {
        userPostList = userPostListModel.obs;
      } else {
        userPostList.update((val) {
          val!.userPosts.addAll(userPostListModel.userPosts);
          val.last = userPostListModel.last;
        });
      }

      isLoadPost.value = true;
    } else {
      isLoadPost.value = false;

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserCommentedPostList(isFirstPage);
      });
    }

    isRefreshing = false;
  }

  Future<void> _getUserLikedPostList(bool isFirstPage) async {

    isRefreshing = true;

    if(isFirstPage){
      isLoadPost.value = false;
      _page = 0;
    }else{
      _page++;
    }

    final ApiResponseDTO apiResponseDTO = await _userInfoRepository.getUserLikedPostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final UserPostListModel userPostListModel = apiResponseDTO.data as UserPostListModel;

      await getThumbnailList(userPostListModel.userPosts);

      if (isFirstPage) {
        userPostList = userPostListModel.obs;
      } else {
        userPostList.update((val) {
          val!.userPosts.addAll(userPostListModel.userPosts);
          val.last = userPostListModel.last;
        });
      }

      isLoadPost.value = true;
    } else {
      isLoadPost.value = false;

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserLikedPostList(isFirstPage);
      });
    }

    isRefreshing = false;
  }

  Future<void> getThumbnailList(List<UserPostModel> postList) async {
    for (UserPostModel i in postList) {
      for (FileModel j in i.files) {
        j.thumbnailUrl = (await fileFromImageUrl(
            j.thumbnailUrl, ("thumbnail_${j.originalName ?? "$i"}"))).path;
      }
    }
  }

}
