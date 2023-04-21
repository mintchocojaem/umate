import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/timetable/model/lecture_model.dart';
import 'package:danvery/ui/pages/main/timetable_page/controller/timetable_page_controller.dart';
import 'package:danvery/ui/widgets/color_picker/color_picker.dart';
import 'package:danvery/ui/widgets/day_picker/day_picker.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/timetable/timetable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimetablePage extends GetView<TimetablePageController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: MainAppBar(
        title: "2023 1학기",
        titleStyle: smallTitleStyle.copyWith(color: Palette.black),
        isDarkMode: Get.isDarkMode,
        backGroundColor: Palette.pureWhite,
        actions: [
          /*
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(
              Icons.ios_share_rounded,
              color: Palette.blue,
            ),
          ),
           */
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              timetableBottomSheet();
            },
            icon: Icon(
              Icons.add_circle_outline_outlined,
              color: Palette.blue,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return Timetable(
                subjects: controller.subjects.map((e) => e.value).toList(),
                today: controller.today,
                onSubjectTap: (subject) {
                  timetableBottomSheet(subjectModel: subject);
                },
                tableStartTime: 9,
                tableEndTime: 20,
              );
            })
            /*
            const Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: BoardList(
                cards: [BoardCard(leadingText: "소프트웨어학과", title: "이관현")],
                title: "친구",
                actionTitle: "",
                showAction: false,
              ),
            )
             */
          ],
        ),
      ),
    );
  }

  void timetableBottomSheet({LectureModel? subjectModel}) {
    Get.bottomSheet(
      GetBuilder<TimetableBottomSheetController>(
          autoRemove: false,
          init: TimetableBottomSheetController(),
          builder: (bottomSheetController) {
            if (subjectModel != null) {
              bottomSheetController.initBottomSheetSubject(subjectModel);
            }
            return Obx(
              () => SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          subjectModel == null
                              ? IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    //close bottom sheet
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Palette.blue,
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    //delete subject
                                    controller.deleteSubject(subjectModel);
                                    Get.back();
                                  },
                                  child: Text(
                                    "삭제",
                                    style: regularStyle.copyWith(
                                        color: Palette.blue),
                                  ),
                                ),
                          subjectModel == null
                              ? TextButton(
                                  onPressed: () {
                                    //add subject
                                    final LectureModel? newSchedule =
                                        bottomSheetController
                                            .makeNewSubjectModel();
                                    if (newSchedule != null) {
                                      if (controller.addSubject(newSchedule)) {
                                        Get.back();
                                      }
                                    }
                                  },
                                  child: Text(
                                    "추가",
                                    style: regularStyle.copyWith(
                                        color: Palette.blue),
                                  ),
                                )
                              : TextButton(
                                  onPressed: () {
                                    //update subject
                                    final LectureModel? newSchedule =
                                        bottomSheetController
                                            .makeNewSubjectModel();
                                    if (newSchedule != null) {
                                      controller.updateSubject(
                                          subjectModel, newSchedule);
                                      Get.back();
                                    }
                                  },
                                  child: Text(
                                    "완료",
                                    style: regularStyle.copyWith(
                                        color: Palette.blue),
                                  ),
                                ),
                        ],
                      ),
                      subjectModel == null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                  fillColor:
                                      MaterialStateProperty.all(Palette.blue),
                                  value: true,
                                  groupValue:
                                      bottomSheetController.isSubjectAdd.value,
                                  onChanged: (value) {
                                    bottomSheetController.isSubjectAdd.value =
                                        value!;
                                  },
                                ),
                                Text(
                                  '과목 추가',
                                  style: regularStyle.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(width: 16),
                                Radio(
                                  fillColor:
                                      MaterialStateProperty.all(Palette.blue),
                                  value: false,
                                  groupValue:
                                      bottomSheetController.isSubjectAdd.value,
                                  onChanged: (value) {
                                    bottomSheetController.isSubjectAdd.value =
                                        value!;
                                  },
                                ),
                                Text(
                                  '일정 추가',
                                  style: regularStyle.copyWith(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      bottomSheetController.isSubjectAdd.value
                          ? ModernFormField(
                              initText: bottomSheetController.titleController
                                  .text,
                              controller: bottomSheetController.titleController,
                              hint: "과목명 검색",
                              readOnly: subjectModel != null,
                              suffix: subjectModel == null
                                  ? IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () async {
                                        if (!bottomSheetController.isSearch.value) {
                                          await bottomSheetController.searchLecture();
                                          bottomSheetController.isSearch.value = true;
                                        } else {
                                          bottomSheetController.titleController.clear();
                                          bottomSheetController.isSearch.value = false;
                                        }
                                      },
                                      padding: EdgeInsets.zero,
                                      icon:
                                          !bottomSheetController.isSearch.value
                                              ? const Icon(
                                                  Icons.search,
                                                )
                                              : const Icon(
                                                  Icons.close,
                                                ),
                                    )
                                  : null,
                            )
                          : const ModernFormField(
                              hint: "제목",
                            ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: !bottomSheetController.isSearch.value
                            ? Column(
                                children: [
                                  DayPicker(
                                    selectedDayIndex:
                                        bottomSheetController.days,
                                    days: const [
                                      "월",
                                      "화",
                                      "수",
                                      "목",
                                      "금",
                                    ],
                                    oDaySelected: (value) {},
                                  ),
                                  const SizedBox(height: 8),
                                  Flex(
                                    direction: Axis.horizontal,
                                    children: [
                                      Flexible(
                                        flex: 6,
                                        child: Obx(
                                          () => ModernFormField(
                                            isTime: true,
                                            initText: bottomSheetController
                                                .startTime.value,
                                            hint: "시작 시간",
                                            suffixWidth: 32,
                                            readOnly: subjectModel != null,
                                            onTextChanged: (text) {
                                              bottomSheetController
                                                  .startTime.value = text;
                                            },
                                            suffix: const IconButton(
                                              splashColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onPressed: null,
                                              padding: EdgeInsets.zero,
                                              icon: Icon(Icons
                                                  .keyboard_arrow_down_rounded),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        flex: 6,
                                        child: ModernFormField(
                                          isTime: true,
                                          onTextChanged: (text) {
                                            bottomSheetController
                                                .endTime.value = text;
                                          },
                                          initText: bottomSheetController
                                              .endTime.value,
                                          hint: "종료 시간",
                                          readOnly: subjectModel != null,
                                          suffixWidth: 32,
                                          suffix: IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () {},
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  bottomSheetController.isSubjectAdd.value
                                      ? ModernFormField(
                                          onTextChanged: (text) {
                                            bottomSheetController
                                                .content.value = text;
                                          },
                                          initText: bottomSheetController
                                              .content.value,
                                          readOnly: subjectModel != null,
                                          hint: "강의실",
                                        )
                                      : const ModernFormField(
                                          hint: "메모",
                                        ),
                                  const SizedBox(height: 16),
                                  ColorPicker(
                                    selectedColorIndex: Palette.subjectColors
                                        .indexOf(bottomSheetController
                                            .selectedColor),
                                    colors: Palette.subjectColors,
                                    onColorSelected: (color) {
                                      bottomSheetController.selectedColor =
                                          color;
                                    },
                                  ),
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    bottomSheetController.lectures.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () {
                                      bottomSheetController
                                          .titleController.text =
                                          bottomSheetController
                                              .lectures[index].name;
                                      bottomSheetController.isSearch.value =
                                          false;
                                    },
                                    title: Text(
                                      bottomSheetController
                                          .lectures[index].name,
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      bottomSheetController
                                          .lectures[index].lectureCode,
                                      style: regularStyle.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      enableDrag: false,
      backgroundColor: Palette.pureWhite,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }
}
