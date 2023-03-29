import 'package:danvery/ui/pages/main/timetable_page/controller/timetable_page_controller.dart';
import 'package:danvery/ui/widgets/color_picker/color_picker.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/timetable/timetable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/subject_model.dart';

class TimetablePage extends GetView<TimetablePageController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: MainAppBar(
        title: "2023 1학기",
        titleStyle: titleStyle.copyWith(color: Palette.darkGrey),
        isDarkMode: Get.isDarkMode,
        backGroundColor: Palette.pureWhite,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ios_share_rounded,
              color: Palette.blue,
            ),
          ),
          IconButton(
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

  void timetableBottomSheet({SubjectModel? subjectModel}) {
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
                child: SingleChildScrollView(
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
                                      controller.addSubject(
                                          bottomSheetController
                                              .newSubjectModel());
                                      Get.back();
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
                                      controller.updateSubject(
                                          subjectModel,
                                          bottomSheetController
                                              .newSubjectModel());
                                      Get.back();
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
                                    groupValue: bottomSheetController
                                        .isSubjectAdd.value,
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
                                    groupValue: bottomSheetController
                                        .isSubjectAdd.value,
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
                                onTextChanged: (text) {
                                  bottomSheetController.title.value = text;
                                },
                                initText: bottomSheetController.title.value,
                                hint: "과목명 검색",
                                readOnly: subjectModel != null,
                                suffixIcon: subjectModel == null
                                    ? const Icon(Icons.search)
                                    : null,
                              )
                            : ModernFormField(
                                hint: "제목",
                              ),
                        SizedBox(height: 8),
                        Flex(
                          direction: Axis.horizontal,
                          children: [
                            Flexible(
                              flex: 5,
                              child: ModernFormField(
                                onTextChanged: (text) {
                                  bottomSheetController.days.value = text;
                                },
                                initText: bottomSheetController.days.value,
                                hint: "요일",
                                readOnly: subjectModel != null,
                                suffixIcon:
                                    Icon(Icons.keyboard_arrow_down_rounded),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              flex: 6,
                              child: ModernFormField(
                                onTextChanged: (text) {
                                  bottomSheetController.startTime.value = text;
                                },
                                initText: bottomSheetController.startTime.value,
                                hint: "시작 시간",
                                readOnly: subjectModel != null,
                                suffixIcon:
                                    Icon(Icons.keyboard_arrow_down_rounded),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              flex: 6,
                              child: ModernFormField(
                                onTextChanged: (text) {
                                  bottomSheetController.endTime.value = text;
                                },
                                initText: bottomSheetController.endTime.value,
                                hint: "종료 시간",
                                readOnly: subjectModel != null,
                                suffixIcon:
                                    Icon(Icons.keyboard_arrow_down_rounded),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        bottomSheetController.isSubjectAdd.value
                            ? ModernFormField(
                                onTextChanged: (text) {
                                  bottomSheetController.content.value = text;
                                },
                                initText: bottomSheetController.content.value,
                                readOnly: subjectModel != null,
                                hint: "강의실",
                              )
                            : ModernFormField(
                                hint: "메모",
                              ),
                        SizedBox(height: 16),
                        ColorPicker(
                          selectedColorIndex: Palette.subjectColors
                              .indexOf(bottomSheetController.selectedColor),
                          colors: Palette.subjectColors,
                          onColorSelected: (color) {
                            bottomSheetController.selectedColor = color;
                          },
                        ),
                      ],
                    ),
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
