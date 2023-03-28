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
  final int _generalBoardSize = 5;

  int _petitionBoardPage = 0;
  final int _petitionBoardSize = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    getGeneralPostListBoard();
    getPetitionPostListBoard();

    selectedCategory.listen((value) {
      getPetitionPostListBoard();
    });

    generalBoardScrollController.addListener(() async {
      if (generalBoardScrollController.position.pixels ==
          generalBoardScrollController.position.maxScrollExtent) {
        if (!generalPostBoard.value.last) {
          await getNextGeneralPostListBoard();
        }
      }
    });

    petitionBoardScrollController.addListener(() async {
      if (petitionBoardScrollController.position.pixels ==
          petitionBoardScrollController.position.maxScrollExtent) {
        if (!petitionBoard.value.last) {
          await getNextPetitionPostListBoard();
        }
      }
    });

    super.onInit();
  }

  Future<void> getGeneralPostListBoard() async {
    _generalBoardPage = 0;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText.value)
        .then((value) {
      if (value != null) {
        generalPostBoard.value = value;
        generalPostList.value = value.generalPosts;
        isLoadGeneralPostBoard.value = true;
      }
    });
  }

  Future<void> getNextGeneralPostListBoard() async {
    _generalBoardPage++;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText.value)
        .then((value) {
      if (value != null && value.generalPosts.isNotEmpty) {
        generalPostBoard.value = value;
        generalPostList.addAll(value.generalPosts);
      }
    });
  }

  Future<void> getPetitionPostListBoard() async {
    _petitionBoardPage = 0;
    await _petitionPostRepository
        .getPetitionBoard(
            page: _petitionBoardPage,
            size: _petitionBoardSize,
            status: categoryAPIList[selectedCategory.value])
        .then((value) {
      if (value != null) {
        petitionBoard.value = value;
        petitionPostList.value = value.petitionPosts;
        isLoadPetitionBoard.value = true;
      }
    });
  }

  Future<void> getNextPetitionPostListBoard() async {
    _petitionBoardPage++;
    await _petitionPostRepository
        .getPetitionBoard(
            page: _petitionBoardPage,
            size: _generalBoardSize,
            status: categoryAPIList[selectedCategory.value])
        .then((value) {
      if (value != null && value.petitionPosts.isNotEmpty) {
        petitionBoard.value = value;
        petitionPostList.addAll(value.petitionPosts);
      }
    });
  }

  Future<bool> searchPost(String keyword) async {
    _generalBoardPage = 0;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage, size: _generalBoardSize, keyword: keyword)
        .then((value) {
      if (value != null) {
        generalPostBoard.value = value;
        isLoadGeneralPostBoard.value = true;
        return true;
      }
    });
    return false;
  }
}
