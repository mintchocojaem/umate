import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/timetable_page/model/subject_model.dart';
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

  void updateSubject(SubjectModel model, SubjectModel newModel) {
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

  void addSubject(SubjectModel model) {
    subjects.add(model.obs);
  }

  void deleteSubject(SubjectModel model) {
    subjects.remove(model.obs);
  }

}

class TimetableBottomSheetController extends GetxController {
  final RxBool isSubjectAdd = true.obs;

  Color selectedColor = Palette.subjectColors[0];

  final RxString title = "".obs;

  final RxString days = "".obs;

  final RxString startTime = "".obs;

  final RxString endTime = "".obs;

  final RxString content = "".obs;

  void initBottomSheetSubject(SubjectModel model) {
    title.value = model.name;
    days.value = model.days.join(",");
    startTime.value = model.startTime;
    endTime.value = model.endTime;
    content.value = model.place;
    selectedColor = Color(model.color.value);
  }

  SubjectModel newSubjectModel() {
    return SubjectModel(
      name: title.value,
      startTime: startTime.value,
      endTime: endTime.value,
      days: days.value.split(","),
      place: content.value,
      color: Color(selectedColor.value),
    );
  }

}
