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

  final RxInt _selectedTap = 0.obs;

  int get selectedTap => _selectedTap.value;

  set selectedTap(index) => _selectedTap.value = index;

  final RxInt _selectedCategory = 0.obs;

  int get selectedCategory => _selectedCategory.value;

  set selectedCategory(index) => _selectedCategory.value = index;

  final Rx<GeneralBoardModel> _generalPostBoard = GeneralBoardModel().obs;

  GeneralBoardModel get generalPostBoard => _generalPostBoard.value;

  final RxList<GeneralPostModel> _generalPostList = <GeneralPostModel>[].obs;

  List<GeneralPostModel> get generalPostList => _generalPostList;

  final RxBool _isLoadGeneralPostBoard = false.obs;

  bool get isLoadGeneralPostBoard => _isLoadGeneralPostBoard.value;

  final Rx<PetitionBoardModel> _petitionBoard = PetitionBoardModel().obs;

  PetitionBoardModel get petitionBoard => _petitionBoard.value;

  final RxList<PetitionPostModel> _petitionPostList = <PetitionPostModel>[].obs;

  List<PetitionPostModel> get petitionPostList => _petitionPostList;

  final RxBool _isLoadPetitionBoard = false.obs;

  bool get isLoadPetitionBoard => _isLoadPetitionBoard.value;

  List<String> categoryKORList = ['청원 중', '대기 중', '답변 완료', '기간만료'];
  List<String> categoryAPIList = ['ACTIVE', 'WAITING', 'ANSWERED', 'EXPIRED'];

  final RxString _searchText = ''.obs;

  String get searchText => _searchText.value;

  set searchText(String value) => _searchText.value = value;

  final ScrollController generalBoardScrollController = ScrollController();

  final ScrollController petitionBoardScrollController = ScrollController();

  int _generalBoardPage = 0;
  final int _generalBoardSize = 5;

  int _petitionBoardPage = 0;
  final int _petitionBoardSize = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    getGeneralPostListBoard();
    getPetitionPostListBoard();

    _selectedCategory.listen((value) {
      getPetitionPostListBoard();
    });

    generalBoardScrollController.addListener(() async {
      if (generalBoardScrollController.position.pixels ==
          generalBoardScrollController.position.maxScrollExtent) {
        if (!generalPostBoard.last) {
          await getNextGeneralPostListBoard();
        }
      }
    });

    petitionBoardScrollController.addListener(() async {
      if (petitionBoardScrollController.position.pixels ==
          petitionBoardScrollController.position.maxScrollExtent) {
        if (!petitionBoard.last) {
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
            keyword: searchText)
        .then((value) {
      if (value != null) {
        _generalPostBoard.value = value;
        _generalPostList.value = value.generalPostList;
        _isLoadGeneralPostBoard.value = true;
      }
    });
  }

  Future<void> getNextGeneralPostListBoard() async {
    _generalBoardPage++;
    await _generalBoardRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText)
        .then((value) {
      if (value != null && value.generalPostList.isNotEmpty) {
        _generalPostBoard.value = value;
        _generalPostList.addAll(value.generalPostList);
      }
    });
  }

  Future<void> getPetitionPostListBoard() async {
    _petitionBoardPage = 0;
    await _petitionPostRepository
        .getPetitionBoard(
            page: _petitionBoardPage,
            size: _petitionBoardSize,
            status: categoryAPIList[_selectedCategory.value])
        .then((value) {
      if (value != null) {
        _petitionBoard.value = value;
        _petitionPostList.value = value.petitionPostList;
        _isLoadPetitionBoard.value = true;
      }
    });
  }

  Future<void> getNextPetitionPostListBoard() async {
    _petitionBoardPage++;
    await _petitionPostRepository
        .getPetitionBoard(
            page: _petitionBoardPage,
            size: _generalBoardSize,
            status: categoryAPIList[_selectedCategory.value])
        .then((value) {
      if (value != null && value.petitionPostList.isNotEmpty) {
        _petitionBoard.value = value;
        _petitionPostList.addAll(value.petitionPostList);
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
        _generalPostBoard.value = value;
        _isLoadGeneralPostBoard.value = true;
        return true;
      }
    });
    return false;
  }
}
