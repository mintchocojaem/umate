import 'package:danvery/domain/board/general_board/model/file.dart';
import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/general_board/repository/general_board_repository.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/board/petition_board/repository/petition_board_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BoardPageController extends GetxController {
  final GeneralBoardRepository _generalBoardRepository =
      GeneralBoardRepository();
  final PetitionBoardRepository _petitionPostRepository =
      PetitionBoardRepository();

  final RxInt selectedTap = 0.obs;

  final RxInt selectedCategory = 0.obs;

  final Rx<GeneralBoardModel> generalPostBoard = GeneralBoardModel().obs;

  final RxList<GeneralPostModel> generalPostList = <GeneralPostModel>[].obs;

  final RxBool isLoadGeneralPostBoard = false.obs;

  final Rx<PetitionBoardModel> petitionBoard = PetitionBoardModel().obs;

  final RxList<PetitionPostModel> petitionPostList = <PetitionPostModel>[].obs;

  final RxBool isLoadPetitionBoard = false.obs;

  final RxString searchText = ''.obs;

  final ScrollController generalBoardScrollController = ScrollController();

  final ScrollController petitionBoardScrollController = ScrollController();

  List<String> categoryKORList = ['청원 중', '대기 중', '답변 완료', '기간만료'];
  List<String> categoryAPIList = ['ACTIVE', 'WAITING', 'ANSWERED', 'EXPIRED'];

  int _generalBoardPage = 0;
  final int _generalBoardSize = 10;

  int _petitionBoardPage = 0;
  final int _petitionBoardSize = 10;

  final RxBool isLoadedImageList = false.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    await getFirstGeneralPostBoard();
    await getFirstPetitionPostBoard();

    selectedCategory.listen((value) {
      getFirstPetitionPostBoard();
    });

    generalBoardScrollController.addListener(() async {
      if (generalBoardScrollController.position.pixels ==
          generalBoardScrollController.position.maxScrollExtent) {
        if (!generalPostBoard.value.last) {
          await getNextGeneralPostBoard();
        }
      }
    });

    petitionBoardScrollController.addListener(() async {
      if (petitionBoardScrollController.position.pixels ==
          petitionBoardScrollController.position.maxScrollExtent) {
        if (!petitionBoard.value.last) {
          await getNextPetitionPostBoard();
        }
      }
    });

    super.onInit();
  }

  Future<void> getFirstGeneralPostBoard() async {
    _generalBoardPage = 0;
    isLoadGeneralPostBoard.value = false;
    isLoadedImageList.value = false;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText.value)
        .then((value) async {
      if (value.success) {
        generalPostBoard.value = value.data as GeneralBoardModel;
        final List<GeneralPostModel> postList =
        value.data.generalPosts as List<GeneralPostModel>;
        await getImageList(postList);
        generalPostList.value = postList;
        isLoadGeneralPostBoard.value = true;
      }
    });
  }

  Future<void> getNextGeneralPostBoard() async {
    _generalBoardPage++;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText.value)
        .then((value) async {
      if (value.success && value.data.generalPosts.isNotEmpty) {
        generalPostBoard.value = value.data as GeneralBoardModel;
        final List<GeneralPostModel> postList =
            value.data.generalPosts as List<GeneralPostModel>;
        await getImageList(postList);
        generalPostList.addAll(postList);
      }
    });
  }

  Future<void> getFirstPetitionPostBoard() async {
    _petitionBoardPage = 0;
    isLoadPetitionBoard.value = false;
    await _petitionPostRepository
        .getPetitionBoard(
            page: _petitionBoardPage,
            size: _petitionBoardSize,
            status: categoryAPIList[selectedCategory.value])
        .then((value) {
      if (value.success) {
        petitionBoard.value = value.data as PetitionBoardModel;
        petitionPostList.value =
            value.data.petitionPosts as List<PetitionPostModel>;
        isLoadPetitionBoard.value = true;
      }
    });
  }

  Future<void> getNextPetitionPostBoard() async {
    _petitionBoardPage++;
    await _petitionPostRepository
        .getPetitionBoard(
            page: _petitionBoardPage,
            size: _generalBoardSize,
            status: categoryAPIList[selectedCategory.value])
        .then((value) {
      if (value.success && value.data.petitionPosts.isNotEmpty) {
        petitionBoard.value = value.data as PetitionBoardModel;
        petitionPostList
            .addAll(value.data.petitionPosts as List<PetitionPostModel>);
      }
    });
  }

  Future<bool> searchPost(String keyword) async {
    _generalBoardPage = 0;
    isLoadGeneralPostBoard.value = false;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage, size: _generalBoardSize, keyword: keyword)
        .then((value) {
      if (value.success) {
        searchText.value = keyword;
        generalPostBoard.value = value.data as GeneralBoardModel;
        generalPostList.value =
            value.data.generalPosts as List<GeneralPostModel>;
        isLoadGeneralPostBoard.value = true;
        return true;
      }
    });
    return false;
  }

  Future<void> getImageList(List<GeneralPostModel> postList) async {
    for (GeneralPostModel i in postList) {
      for (FileModel j in i.files) {
        j.url  = (await fileFromImageUrl(j.url, j.originalName ?? "image$i")).path;
      }
    }
    isLoadedImageList.value = true;
  }


}
