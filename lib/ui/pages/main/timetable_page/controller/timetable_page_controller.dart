import 'package:danvery/ui/pages/main/timetable_page/model/subject_model.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimetablePageController extends GetxController {

  final int today = DateTime.now().weekday - 1;

  final RxList<Rx<SubjectModel>> subjects = [
    SubjectModel(
      name: "사업개발과경영",
      startTime: '09:00',
      endTime: '10:00',
      days: ["월", "화"],
      place: "강의실 1",
      color: Palette.subjectColors[9],
    ).obs,
  ].obs;

  void updateSubject(SubjectModel model) {
    subjects[subjects.indexOf(model)].update((val) {
      val!.name = model.name;
      val.startTime = model.startTime;
      val.endTime = model.endTime;
      val.days = model.days;
      val.place = model.place;
      val.color = model.color;
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }
}

class TimetableBottomSheetController extends GetxController {
  final RxBool isSubjectAdd = true.obs;

  Color selectedColor = Palette.subjectColors[0];

  final RxString title = "".obs;

  final RxString day = "".obs;

  final RxString startTime = "".obs;

  final RxString endTime = "".obs;

  final RxString content = "".obs;


  void initBottomSheetSubject(SubjectModel model) {
    title.value = model.name;
    day.value = model.days.join(",");
    startTime.value = model.startTime;
    endTime.value = model.endTime;
    content.value = model.place;
    selectedColor = Color(model.color.value);
  }

  void editSubject(SubjectModel model) {
    model.name = title.value;
    model.days = day.value.split(",");
    model.startTime = startTime.value;
    model.endTime = endTime.value;
    model.place = content.value;
    model.color = selectedColor;
  }
}
