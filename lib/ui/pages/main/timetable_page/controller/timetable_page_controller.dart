import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/timetable/model/lecture_model.dart';
import 'package:danvery/domain/timetable/model/lecture_search_list_model.dart';
import 'package:danvery/domain/timetable/model/lecture_search_model.dart';
import 'package:danvery/domain/timetable/repository/timetable_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimetablePageController extends GetxController {
  final int today = DateTime.now().weekday - 1;

  final RxList<Rx<LectureModel>> subjects = [
    LectureModel(
      name: "사업개발과경영",
      startTime: '10:30',
      endTime: '12:30',
      days: ["월", "화"],
      place: "강의실 1",
      color: Palette.subjectColors[9],
    ).obs,
  ].obs;

  void updateSubject(LectureModel model, LectureModel newModel) {
    subjects[subjects.indexOf(model)].update((val) {
      if (val != null) {
        val.name = newModel.name;
        val.startTime = newModel.startTime;
        val.endTime = newModel.endTime;
        val.days = newModel.days;
        val.place = newModel.place;
        val.color = newModel.color;
      }
    });
  }

  bool addSubject(LectureModel model) {
    if (isOverlappedScheduleTime(model)) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "시간이 겹치는 일정이 존재합니다.")
          .show();
      return false;
    }
    if (!isSatisfyMinimumTime(model)) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "최소 30분 이상의 일정만 추가할 수 있습니다.")
          .show();
      return false;
    }
    subjects.add(model.obs);
    return true;
  }

  void deleteSubject(LectureModel model) {
    subjects.remove(model.obs);
  }

  bool isOverlappedScheduleTime(LectureModel model) {
    for (int i = 0; i < subjects.length; i++) {
      if (subjects[i].value == model) continue;
      if (subjects[i].value.days.contains(model.days[0])) {
        // 해당 수업과 비교하는 수업의 요일이 겹친다면,
        DateTime modelStartTime =
            DateTime.parse("2022-01-01 ${model.startTime}");
        DateTime modelEndTime = DateTime.parse("2022-01-01 ${model.endTime}");
        DateTime subjectStartTime =
            DateTime.parse("2022-01-01 ${subjects[i].value.startTime}");
        DateTime subjectEndTime =
            DateTime.parse("2022-01-01 ${subjects[i].value.endTime}");

        if (modelStartTime.isBefore(subjectEndTime) &&
            modelEndTime.isAfter(subjectStartTime)) {
          // 시간이 겹친다면, false를 반환
          return true;
        }
      }
    }
    return false;
  }

  bool isSatisfyMinimumTime(LectureModel model) {
    DateTime startTime = DateTime.parse("2022-01-01 ${model.startTime}");
    DateTime endTime = DateTime.parse("2022-01-01 ${model.endTime}");
    Duration duration = endTime.difference(startTime);
    return duration.inMinutes >= 30;
  }
}

class TimetableBottomSheetController extends GetxController {
  final TimetableRepository _timetableRepository = TimetableRepository();
  final LoginService _loginService = Get.find<LoginService>();

  final RxBool isSubjectAdd = true.obs;
  final RxBool isSearch = false.obs;
  final RxBool isSearchLoaded = false.obs;

  Color selectedColor = Palette.subjectColors[0];

  final List<String> daysText = ["월", "화", "수", "목", "금", "토", "일"];

  late LectureSearchListModel lectureSearchList;

  final RxList<LectureSearchModel> lectures = <LectureSearchModel>[].obs;

  final TextEditingController titleController = TextEditingController();
  final RxString title = "".obs;

  final RxList<int> days = [0].obs;

  final RxString startTime = "".obs;

  final RxString endTime = "".obs;

  final RxString content = "".obs;

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(() {
      title.value = titleController.text;
    });
  }

  void initBottomSheetSubject(LectureModel model) {
    title.value = model.name;
    days.value = model.days.map((e) => daysText.indexOf(e)).toList();
    startTime.value = model.startTime;
    endTime.value = model.endTime;
    content.value = model.place;
    selectedColor = Color(model.color.value);
  }

  Future<void> searchLecture() async {
    isSearchLoaded.value = false;
    final ApiResponseDTO response = await _timetableRepository.searchLecture(
        _loginService.token.value.accessToken, title.value);
    if (response.success) {
      lectureSearchList = response.data as LectureSearchListModel;
      lectures.value = lectureSearchList.content;
    }
    isSearchLoaded.value = true;
  }

  LectureModel? makeNewSubjectModel() {
    if (title.value.isEmpty) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "일정 제목을 입력해주세요.")
          .show();
      return null;
    }
    if (days.isEmpty) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "일정 요일을 선택해주세요.")
          .show();
      return null;
    }
    if (startTime.value.isEmpty) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "일정 시작 시간을 선택해주세요.")
          .show();
      return null;
    }
    if (endTime.value.isEmpty) {
      GetXSnackBar(
              type: GetXSnackBarType.customError,
              title: "일정 생성 오류",
              content: "일정 종료 시간을 선택해주세요.")
          .show();
      return null;
    }
    return LectureModel(
      name: title.value,
      startTime: startTime.value,
      endTime: endTime.value,
      days: days.map((e) => daysText[e]).toList(),
      place: content.value,
      color: Color(selectedColor.value),
    );
  }
}
