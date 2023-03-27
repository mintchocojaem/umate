import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BoardPageController extends GetxController {
  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();
  final PetitionPostRepository _petitionPostRepository =
      PetitionPostRepository();

  final RxInt _selectedTap = 0.obs;

  int get selectedTap => _selectedTap.value;

  set selectedTap(index) => _selectedTap.value = index;

  final RxInt _selectedCategory = 0.obs;

  int get selectedCategory => _selectedCategory.value;

  set selectedCategory(index) => _selectedCategory.value = index;

  final RxList<GeneralPostModel> _generalPostListBoard =
      <GeneralPostModel>[].obs;

  List<GeneralPostModel> get generalPostListBoard => _generalPostListBoard;

  final RxBool _isLoadGeneralPostListBoard = false.obs;

  bool get isLoadGeneralPostListBoard => _isLoadGeneralPostListBoard.value;

  final RxBool _isLoadMoreGeneralPostListBoard = false.obs;

  bool get isLoadMoreGeneralPostListBoard =>
      _isLoadMoreGeneralPostListBoard.value;

  final RxList<PetitionPostModel> _petitionListBoard =
      <PetitionPostModel>[].obs;

  List<PetitionPostModel> get petitionListBoard => _petitionListBoard;

  final RxBool _isLoadPetitionListBoard = false.obs;

  bool get isLoadPetitionListBoard => _isLoadPetitionListBoard.value;

  List<String> categoryKORList = ['청원 중', '대기 중', '답변 완료', '기간만료'];
  List<String> categoryAPIList = ['ACTIVE', 'WAITING', 'ANSWERED', 'EXPIRED'];

  final RxString _searchText = ''.obs;

  String get searchText => _searchText.value;

  set searchText(String value) => _searchText.value = value;

  final ScrollController scrollController = ScrollController();

  int _generalBoardPage = 0;
  final int _generalBoardSize = 5;

  @override
  void onInit() {
    // TODO: implement onInit
    getFirstGeneralPostListBoard();
    getPetitionPostListBoard();

    _selectedCategory.listen((value) {
      _petitionPostRepository
          .getPetitionBoard(
              page: 0,
              size: 5,
              status: categoryAPIList[_selectedCategory.value])
          .then((value) {
        if (value != null) {
          _petitionListBoard.value = value;
          _isLoadPetitionListBoard.value = true;
        }
      });
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getNextGeneralPostListBoard().whenComplete(() {
          _isLoadMoreGeneralPostListBoard.value = true;
        });
      }
    });

    super.onInit();
  }

  Future<void> getFirstGeneralPostListBoard() async {
    _generalBoardPage = 0;
    await _generalPostRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText)
        .then((value) {
      if (value != null) {
        _generalPostListBoard.value = value;
        _isLoadGeneralPostListBoard.value = true;
        _isLoadMoreGeneralPostListBoard.value = false;
      }
    });
  }

  Future<void> getNextGeneralPostListBoard() async {
    _generalBoardPage++;
    _isLoadMoreGeneralPostListBoard.value = false;
    await _generalPostRepository
        .getGeneralBoard(
            page: _generalBoardPage,
            size: _generalBoardSize,
            keyword: searchText)
        .then((value) {
      if (value != null && value.isNotEmpty) {
        _generalPostListBoard.addAll(value);
      } else if (value != null) {
        _generalBoardPage--;
      } else {
        _generalBoardPage--;
      }
    });
  }

  Future<void> getPetitionPostListBoard() async {
    _isLoadPetitionListBoard.value = false;
    await _petitionPostRepository
        .getPetitionBoard(
            page: 0, size: 5, status: categoryAPIList[_selectedCategory.value])
        .then((value) {
      if (value != null) {
        _petitionListBoard.value = value;
        _isLoadPetitionListBoard.value = true;
      }
    });
  }

  Future<bool> searchPost(String keyword) async {
    _isLoadGeneralPostListBoard.value = false;
    await _generalPostRepository
        .getGeneralBoard(page: 0, size: 5, keyword: keyword)
        .then((value) {
      if (value != null) {
        _generalPostListBoard.value = value;
        _isLoadGeneralPostListBoard.value = true;
        return true;
      }
    });
    return false;
  }
}
