import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/user/info/repository/userInfo_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/service/permission/permission_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum MyPagePostType { general, petition, comment, like }

extension MyPagePostTypeExtension on MyPagePostType {
  String get title {
    switch (this) {
      case MyPagePostType.general:
        return "내가 게시한 글";
      case MyPagePostType.petition:
        return "내가 청원한 글";
      case MyPagePostType.comment:
        return "내가 댓글 단 글";
      case MyPagePostType.like:
        return "내가 좋아요한 글";
    }
  }
}

class MyPagePageController extends GetxController  {
  final PermissionService permissionService = Get.find<PermissionService>();
  final LoginService loginService = Get.find<LoginService>();
  final UserInfoRepository _userInfoRepository = UserInfoRepository();

  Rx<TextEditingController> nickname = TextEditingController().obs;
  Rx<TextEditingController> currentPassword = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> passwordValidate = TextEditingController().obs;
  Rx<TextEditingController> phoneNumber = TextEditingController().obs;
  Rx<TextEditingController> phoneAuthenticationNumber =
      TextEditingController().obs;

  late Rx<GeneralBoardModel> userGeneralPostList;
  late Rx<PetitionBoardModel> userPetitionPostList;

  int _page = 0;
  int size = 10;

  List<MyPagePostType> myPagePostType = [
    MyPagePostType.general,
  ];

  final ScrollController generaPostListScroller = ScrollController();
  final ScrollController petitionPostListScroller = ScrollController();

  final RxBool isLoadGeneralPostList = false.obs;
  final RxBool isLoadPetitionPostList = false.obs;

  bool isRefreshing = false;

  final RxInt userWritePostCount = 0.obs;
  final RxInt userCommentedPostCount = 0.obs;
  final RxInt userLikedPostCount = 0.obs;

  final RxInt selectedTabIndex = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit

    nickname.value.text = loginService.userInfo.value.nickname;

    generaPostListScroller.addListener(() async {
      if (generaPostListScroller.position.pixels ==
          generaPostListScroller.position.maxScrollExtent) {
        if (!userGeneralPostList.value.last) {
          await getUserPostListWithRefresh(false);
        }
      }
    });
    petitionPostListScroller.addListener(() async {
      if (petitionPostListScroller.position.pixels ==
          petitionPostListScroller.position.maxScrollExtent) {
        if (!userPetitionPostList.value.last) {
          await getUserPostListWithRefresh(false);
        }
      }
    });
    super.onInit();
  }

  void initEditPage() {
    nickname.value.text = loginService.userInfo.value.nickname;
    currentPassword.value.clear();
    password.value.clear();
    passwordValidate.value.clear();
    phoneNumber.value.text = loginService.userInfo.value.phoneNumber;
    phoneAuthenticationNumber.value.clear();
  }

  late String changePhoneNumberToken;

  Future<void> changeNickname() async {
    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.changeNickname(
            accessToken: loginService.token.value.accessToken,
            nickName: nickname.value.text);
    if (apiResponseDTO.success) {
      loginService.userInfo.value.nickname = nickname.value.text;
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

  Future<void> changePassword() async {
    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.changePassword(
      accessToken: loginService.token.value.accessToken,
      currentPassword: currentPassword.value.text,
      newPassword: password.value.text,
    );
    if (apiResponseDTO.success) {
      await loginService.logout();
      GetXSnackBar(
              type: GetXSnackBarType.info,
              title: "비밀번호 변경 성공",
              content: "비밀번호가 변경되었습니다.")
          .show();
    } else {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "비밀번호 변경 오류",
              content: apiResponseDTO.message)
          .show();
    }
  }

  Future<void> getUserPostListWithRefresh(bool isFirstPage) async {
    if (!isRefreshing) {
      isRefreshing = true;
      if (myPagePostType.contains(MyPagePostType.general)) {
        await _getUserWriteGeneralPostList(isFirstPage);
      }
      if (myPagePostType.contains(MyPagePostType.petition)) {
        await _getUserWritePetitionPostList(isFirstPage);
      }
      if(myPagePostType.contains(MyPagePostType.comment)){
        await _getUserCommentedPostList(isFirstPage);
      }
      if(myPagePostType.contains(MyPagePostType.like)){
        await _getUserLikedPostList(isFirstPage);
      }
      isRefreshing = false;
    }
  }

  Future<void> _getUserWriteGeneralPostList(bool isFirstPage) async {

    if (isFirstPage) {
      isLoadGeneralPostList.value = false;
      _page = 0;
    } else {
      _page++;
    }

    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.getUserWriteGeneralPostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final GeneralBoardModel userGeneralPostListModel =
          apiResponseDTO.data as GeneralBoardModel;

      await getThumbnailList(userGeneralPostListModel.generalPosts);

      if (isFirstPage) {
        userGeneralPostList = userGeneralPostListModel.obs;
      } else {

        userGeneralPostList.update((val) {
          val!.generalPosts.addAll(userGeneralPostListModel.generalPosts);
          val.last = userGeneralPostListModel.last;
        });
      }

      isLoadGeneralPostList.value = true;
    } else {

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserWriteGeneralPostList(isFirstPage);
      });
    }

  }

  Future<void> _getUserWritePetitionPostList(bool isFirstPage) async {

    if (isFirstPage) {
      isLoadPetitionPostList.value = false;
      _page = 0;
    } else {
      _page++;
    }

    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.getUserWritePetitionPostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final PetitionBoardModel userPetitionPostListModel =
          apiResponseDTO.data as PetitionBoardModel;

      await getThumbnailList(userPetitionPostListModel.petitionPosts);

      if (isFirstPage) {
        userPetitionPostList = userPetitionPostListModel.obs;
      } else {
        userPetitionPostList.update((val) {
          val!.petitionPosts.addAll(userPetitionPostListModel.petitionPosts);
          val.last = userPetitionPostListModel.last;
        });
      }

      isLoadPetitionPostList.value = true;
    } else {

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserWritePetitionPostList(isFirstPage);
      });
    }
  }

  Future<void> _getUserCommentedPostList(bool isFirstPage) async {

    if (isFirstPage) {
      isLoadGeneralPostList.value = false;
      _page = 0;
    } else {
      _page++;
    }

    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.getUserCommentedPostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final GeneralBoardModel userGeneralPostListModel =
          apiResponseDTO.data as GeneralBoardModel;

      await getThumbnailList(userGeneralPostListModel.generalPosts);

      if (isFirstPage) {
        userGeneralPostList = userGeneralPostListModel.obs;
      } else {
        userGeneralPostList.update((val) {
          val!.generalPosts.addAll(userGeneralPostListModel.generalPosts);
          val.last = userGeneralPostListModel.last;
        });
      }

      isLoadGeneralPostList.value = true;
    } else {

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserCommentedPostList(isFirstPage);
      });
    }

  }

  Future<void> _getUserLikedPostList(bool isFirstPage) async {

    if (isFirstPage) {
      isLoadGeneralPostList.value = false;
      _page = 0;
    } else {
      _page++;
    }

    final ApiResponseDTO apiResponseDTO =
        await _userInfoRepository.getUserLikedPostList(
      accessToken: loginService.token.value.accessToken,
      page: _page,
      size: size,
    );

    if (apiResponseDTO.success) {
      final GeneralBoardModel userGeneralPostListModel =
          apiResponseDTO.data as GeneralBoardModel;

      await getThumbnailList(userGeneralPostListModel.generalPosts);

      if (isFirstPage) {
        userGeneralPostList = userGeneralPostListModel.obs;
      } else {
        userGeneralPostList.update((val) {
          val!.generalPosts.addAll(userGeneralPostListModel.generalPosts);
          val.last = userGeneralPostListModel.last;
        });
      }

      isLoadGeneralPostList.value = true;
    } else {

      if (!isFirstPage) {
        _page--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getUserLikedPostList(isFirstPage);
      });

    }
  }

  Future<void> getThumbnailList(List postList) async {
    for (var i in postList) {
      for (FileModel j in i.files) {
        j.thumbnailUrl = (await fileFromImageUrl(
                j.thumbnailUrl, ("thumbnail_${j.originalName ?? "$i"}")))
            .path;
      }
    }
  }

  Future<void> getUserInfo() async {
    if (await loginService.getUserInfo()) {
      userWritePostCount.value = loginService.userInfo.value.writeCount;
      userCommentedPostCount.value = loginService.userInfo.value.commentCount;
      userLikedPostCount.value = loginService.userInfo.value.likeCount;
    }
  }
}
