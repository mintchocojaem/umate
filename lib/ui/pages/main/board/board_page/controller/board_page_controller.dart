import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/general_board/repository/general_board_repository.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/board/petition_board/repository/petition_board_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardPageController extends GetxController {
  final GeneralBoardRepository _generalBoardRepository =
      GeneralBoardRepository();
  final PetitionBoardRepository _petitionPostRepository =
      PetitionBoardRepository();

  final LoginService _loginService = LoginService();

  final RxInt selectedTap = 0.obs;

  final RxInt selectedCategory = 0.obs;

  late Rx<GeneralBoardModel> generalPostBoard;

  final RxBool isLoadGeneralPostBoard = false.obs;

  late Rx<PetitionBoardModel> petitionBoard;

  final RxBool isLoadPetitionBoard = false.obs;

  final RxString searchText = ''.obs;

  final ScrollController generalBoardScrollController = ScrollController();

  final ScrollController petitionBoardScrollController = ScrollController();

  int _generalBoardPage = 0;
  final int _generalBoardSize = 10;

  int _petitionBoardPage = 0;
  final int _petitionBoardSize = 10;

  final RxBool isLoadedImageList = false.obs;

  bool isRefreshGeneralPostBoard = false;
  bool isRefreshPetitionPostBoard = false;

  @override
  void onInit() async {
    // TODO: implement onInit

    await getGeneralPostBoardWithRefresh(true);
    await getPetitionPostBoardWithRefresh(true);

    selectedCategory.listen((value) async {
      await getPetitionPostBoardWithRefresh(true);
    });

    generalBoardScrollController.addListener(() async {
      if (generalBoardScrollController.position.pixels ==
          generalBoardScrollController.position.maxScrollExtent) {
        if (!generalPostBoard.value.last) {
          await getGeneralPostBoardWithRefresh(false);
        }
      }
    });

    petitionBoardScrollController.addListener(() async {
      if (petitionBoardScrollController.position.pixels ==
          petitionBoardScrollController.position.maxScrollExtent) {
        if (!petitionBoard.value.last) {
          await getPetitionPostBoardWithRefresh(false);
        }
      }
    });

    super.onInit();
  }

  Future<void> getGeneralPostBoardWithRefresh(bool isFirstPage)async{
    if(!isRefreshGeneralPostBoard){
      isRefreshGeneralPostBoard = true;
      await _getGeneralPostBoard(isFirstPage);
      isRefreshGeneralPostBoard = false;
    }
  }

  Future<void> _getGeneralPostBoard(bool isFirstPage) async {

    if(isFirstPage){
      isLoadGeneralPostBoard.value = false;
      _generalBoardPage = 0;
    }else{
      _generalBoardPage++;
    }

    final ApiResponseDTO apiResponseDTO = await _generalBoardRepository.getGeneralBoard(
      accessToken: _loginService.token.value.accessToken,
      page: _generalBoardPage,
      size: _generalBoardSize,
      keyword: searchText.value,
    );

    if (apiResponseDTO.success) {
      final GeneralBoardModel generalBoardModel = apiResponseDTO.data as GeneralBoardModel;

      await getThumbnailList(generalBoardModel.generalPosts);

      if (isFirstPage) {
        generalPostBoard = generalBoardModel.obs;
      } else {
        generalPostBoard.update((val) {
          if(val != null){
            val.generalPosts.addAll(generalBoardModel.generalPosts);
            val.last = generalBoardModel.last;
          }
        });
      }

      isLoadGeneralPostBoard.value = true;
    } else {
      isLoadGeneralPostBoard.value = false;
      if (!isFirstPage) {
        _generalBoardPage--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getGeneralPostBoard(isFirstPage);
      });
    }

    isLoadGeneralPostBoard.value = true;
    isLoadedImageList.value = true;
  }

  Future<void> getPetitionPostBoardWithRefresh(bool isFirstPage) async {
    if (!isRefreshPetitionPostBoard) {
      isRefreshPetitionPostBoard = true;
      await _getPetitionPostBoard(isFirstPage);
      isRefreshPetitionPostBoard = false;
    }
  }

  Future<void> _getPetitionPostBoard(bool isFirstPage) async {

    if(isFirstPage){
      isLoadPetitionBoard.value = false;
      _petitionBoardPage = 0;
    }else{
      _petitionBoardPage++;
    }

    final ApiResponseDTO apiResponseDTO = await _petitionPostRepository.getPetitionBoard(
        accessToken: _loginService.token.value.accessToken,
        page: _petitionBoardPage,
        size: _petitionBoardSize,
        status: PetitionPostStatus.values[selectedCategory.value].name,
        keyword: searchText.value);

    if (apiResponseDTO.success) {
      final PetitionBoardModel petitionBoardModel = apiResponseDTO.data as PetitionBoardModel;

      if (isFirstPage) {
        petitionBoard = petitionBoardModel.obs;
      } else {
        petitionBoard.update((val) {
          if(val != null){
            val.petitionPosts.addAll(petitionBoardModel.petitionPosts);
            val.last = petitionBoardModel.last;
          }
        });
      }

      isLoadPetitionBoard.value = true;
    } else {
      isLoadPetitionBoard.value = false;

      if (!isFirstPage) {
        _petitionBoardPage--;
      }

      await Future.delayed(const Duration(seconds: 10), () {
        _getPetitionPostBoard(isFirstPage);
      });
    }

    isLoadPetitionBoard.value = true;
    isLoadedImageList.value = true;
  }

  Future<void> getThumbnailList(List<GeneralPostModel> postList) async {
    for (GeneralPostModel i in postList) {
      for (FileModel j in i.files) {
        j.thumbnailUrl = (await fileFromImageUrl(
                j.thumbnailUrl, ("thumbnail_${j.originalName ?? "$i"}")))
            .path;
      }
    }
    isLoadedImageList.value = true;
  }

}
