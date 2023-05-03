import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/timetable/model/lecture/schedule_model.dart';
import 'package:danvery/domain/timetable/model/lecture/schedule_time.dart';
import 'package:danvery/ui/pages/main/timetable_page/controller/timetable_page_controller.dart';
import 'package:danvery/ui/widgets/color_picker/color_picker.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/ui/widgets/modern/modern_form_field.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/timetable/timetable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimetablePage extends GetView<TimetablePageController> {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: MainAppBar(
        title: "시간표",
        titleStyle: smallTitleStyle.copyWith(color: Palette.black),
        isDarkMode: Get.isDarkMode,
        backGroundColor: Palette.pureWhite,
        actions: [
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
                isLoading: !controller.isLoadTimetable.value,
                schedules: controller.isLoadTimetable.value
                    ? controller.timetables.first.value.schedules
                        .map((e) => e)
                        .toList()
                    : [],
                today: controller.today,
                onSubjectTap: (subject) {
                  timetableBottomSheet(subjectModel: subject);
                },
                tableStartTime: 9,
                tableEndTime: 24,
              );
            })
          ],
        ),
      ),
    );
  }

  void timetableBottomSheet({ScheduleModel? subjectModel}) {
    Get.bottomSheet(
      GetBuilder<TimetableBottomSheetController>(
          autoRemove: false,
          init: TimetableBottomSheetController(),
          builder: (bottomSheetController) {
            if (subjectModel != null) {
              bottomSheetController.initBottomSheet(subjectModel);
            }
            return SafeArea(
              child: Obx(
                () => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
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
                              : ModernFormButton(
                                  width: 60,
                                  height: 40,
                                  coolDownTime: 3,
                                  enabledBackgroundColor: Palette.pureWhite,
                                  disabledBackgroundColor: Palette.pureWhite,
                                  disabledTextColor: Palette.grey,
                                  enabledTextColor: Palette.lightRed,
                                  onPressed: () async {
                                    //delete subject
                                    showCupertinoDialog(
                                      context: Get.context!,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: const Text("일정 삭제"),
                                          content:
                                              const Text("해당 일정을 삭제하시겠습니까?"),
                                          actions: [
                                            CupertinoDialogAction(
                                              child: const Text(
                                                '취소',
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text(
                                                '확인',
                                                style: TextStyle(
                                                  color: Palette.lightRed,
                                                ),
                                              ),
                                              onPressed: () async {
                                                Get.back();
                                                await controller.deleteSchedule(
                                                    subjectModel);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  text: '삭제',
                                ),
                          subjectModel == null
                              ? ModernFormButton(
                                  width: 60,
                                  height: 40,
                                  coolDownTime: 3,
                                  text: "추가",
                                  enabledBackgroundColor: Palette.pureWhite,
                                  disabledBackgroundColor: Palette.pureWhite,
                                  enabledTextColor: Palette.blue,
                                  disabledTextColor: Palette.grey,
                                  onPressed: () async {
                                    //add subject
                                    final ScheduleModel? newSchedule =
                                        bottomSheetController
                                            .makeNewLectureModel();
                                    if (newSchedule != null) {
                                      await controller.addSchedule(newSchedule);
                                    }
                                  },
                                )
                              : ModernFormButton(
                                  width: 60,
                                  height: 40,
                                  coolDownTime: 3,
                                  text: "완료",
                                  enabledBackgroundColor: Palette.pureWhite,
                                  disabledBackgroundColor: Palette.pureWhite,
                                  enabledTextColor: Palette.blue,
                                  disabledTextColor: Palette.grey,
                                  onPressed: () async {
                                    //update subject
                                    final ScheduleModel? newSchedule =
                                        bottomSheetController
                                            .makeNewLectureModel();
                                    if (newSchedule != null) {
                                      await controller.updateSchedule(
                                          subjectModel, newSchedule);
                                    }
                                  },
                                )
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
                                      bottomSheetController.isLectureAdd.value,
                                  onChanged: (value) {
                                    bottomSheetController.isLectureAdd.value =
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
                                      bottomSheetController.isLectureAdd.value,
                                  onChanged: (value) {
                                    bottomSheetController.isLectureAdd.value =
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
                          : const SizedBox(
                              height: 8,
                            ),
                      Expanded(
                        child: Column(
                          children: [
                            bottomSheetController.isLectureAdd.value
                                ? ModernFormField(
                                    initText: bottomSheetController
                                        .titleController.text,
                                    controller:
                                        bottomSheetController.titleController,
                                    hint: "과목명",
                                    suffix: subjectModel == null
                                        ? IconButton(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onPressed: () async {
                                              if (!bottomSheetController
                                                  .isSearch.value) {
                                                await bottomSheetController
                                                    .searchLecture();
                                                bottomSheetController
                                                    .isSearch.value = true;
                                              } else {
                                                bottomSheetController
                                                    .titleController
                                                    .clear();
                                                bottomSheetController
                                                    .isSearch.value = false;
                                              }
                                            },
                                            padding: EdgeInsets.zero,
                                            icon: !bottomSheetController
                                                    .isSearch.value
                                                ? const Icon(
                                                    Icons.search,
                                                  )
                                                : const Icon(
                                                    Icons.close,
                                                  ),
                                          )
                                        : null,
                                  )
                                : ModernFormField(
                                    hint: "제목",
                                    initText: bottomSheetController
                                        .titleController.text,
                                    controller:
                                        bottomSheetController.titleController,
                                  ),
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    !bottomSheetController.isSearch.value
                                        ? Column(
                                            children: [
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: bottomSheetController
                                                    .times.length,
                                                shrinkWrap: true,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 8),
                                                    child: Flex(
                                                      direction:
                                                          Axis.horizontal,
                                                      children: [
                                                        Flexible(
                                                          flex: 4,
                                                          child:
                                                              ModernFormField(
                                                            isDay: true,
                                                            initText:
                                                                bottomSheetController
                                                                    .times[
                                                                        index]
                                                                    .value
                                                                    .week
                                                                    .nameKR,
                                                            hint: "월",
                                                            suffixWidth: 32,
                                                            onTextChanged:
                                                                (text) {
                                                              bottomSheetController
                                                                      .times[index]
                                                                      .value
                                                                      .week =
                                                                  WeekOfDay.values.firstWhere(
                                                                      (element) =>
                                                                          element
                                                                              .nameKR ==
                                                                          text);
                                                            },
                                                            suffix:
                                                                const IconButton(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onPressed: null,
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              icon: Icon(Icons
                                                                  .keyboard_arrow_down_rounded),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Flexible(
                                                          flex: 6,
                                                          child:
                                                              ModernFormField(
                                                            isTime: true,
                                                            initText:
                                                                bottomSheetController
                                                                    .times[
                                                                        index]
                                                                    .value
                                                                    .start,
                                                            hint: "시작 시간",
                                                            suffixWidth: 32,
                                                            onTextChanged:
                                                                (text) {
                                                              bottomSheetController
                                                                  .times[index]
                                                                  .value
                                                                  .start = text;
                                                            },
                                                            suffix:
                                                                const IconButton(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onPressed: null,
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              icon: Icon(Icons
                                                                  .keyboard_arrow_down_rounded),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        Flexible(
                                                          flex: 6,
                                                          child:
                                                              ModernFormField(
                                                            isTime: true,
                                                            onTextChanged:
                                                                (text) {
                                                              bottomSheetController
                                                                  .times[index]
                                                                  .value
                                                                  .end = text;
                                                            },
                                                            initText:
                                                                bottomSheetController
                                                                    .times[
                                                                        index]
                                                                    .value
                                                                    .end,
                                                            hint: "종료 시간",
                                                            suffixWidth: 32,
                                                            suffix: IconButton(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onPressed: () {},
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              icon: const Icon(
                                                                Icons
                                                                    .keyboard_arrow_down_rounded,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        index == 0 &&
                                                                bottomSheetController
                                                                        .times
                                                                        .length <
                                                                    5
                                                            ? InkWell(
                                                                child: SizedBox(
                                                                  width: 40,
                                                                  child: Icon(
                                                                    Icons
                                                                        .add_circle_outline,
                                                                    color: Palette
                                                                        .blue,
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  bottomSheetController
                                                                      .times
                                                                      .add(
                                                                    ScheduleTime(
                                                                            start:
                                                                                "09:00",
                                                                            end:
                                                                                "10:00",
                                                                            week:
                                                                                WeekOfDay.monday)
                                                                        .obs,
                                                                  );
                                                                },
                                                              )
                                                            : InkWell(
                                                                child: SizedBox(
                                                                  width: 40,
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove_circle_outline,
                                                                    color: Palette
                                                                        .lightRed,
                                                                    size: 24,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  bottomSheetController
                                                                      .times
                                                                      .removeAt(
                                                                          index);
                                                                },
                                                              ),
                                                        const SizedBox(
                                                            width: 8),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              bottomSheetController
                                                      .isLectureAdd.value
                                                  ? ModernFormField(
                                                      onTextChanged: (text) {
                                                        bottomSheetController
                                                            .contentController
                                                            .text = text;
                                                      },
                                                      initText:
                                                          bottomSheetController
                                                              .contentController
                                                              .text,
                                                      hint: "강의실",
                                                    )
                                                  : const SizedBox(),
                                              const SizedBox(height: 8),
                                              ModernFormField(
                                                onTextChanged: (text) {
                                                  bottomSheetController
                                                      .memoController
                                                      .text = text;
                                                },
                                                initText: bottomSheetController
                                                    .memoController.text,
                                                hint: "메모",
                                              ),
                                              const SizedBox(height: 16),
                                              ColorPicker(
                                                selectedColorIndex: Palette
                                                    .subjectColors
                                                    .indexOf(
                                                        bottomSheetController
                                                            .selectedColor),
                                                colors: Palette.subjectColors,
                                                onColorSelected: (color) {
                                                  bottomSheetController
                                                      .selectedColor = color;
                                                },
                                              ),
                                            ],
                                          )
                                        : bottomSheetController
                                                .lectures.isNotEmpty
                                            ? ListView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: bottomSheetController
                                                    .lectures.length,
                                                itemBuilder: (context, index) {
                                                  return Column(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          bottomSheetController
                                                                  .titleController
                                                                  .text =
                                                              bottomSheetController
                                                                  .lectures[
                                                                      index]
                                                                  .name;
                                                          bottomSheetController
                                                              .isSearch
                                                              .value = false;
                                                          bottomSheetController
                                                                  .times =
                                                              bottomSheetController
                                                                  .lectures[
                                                                      index]
                                                                  .times
                                                                  .map((e) {
                                                                    e.place ??
                                                                        (e.place =
                                                                            "");
                                                                    return e
                                                                        .obs;
                                                                  })
                                                                  .toList()
                                                                  .obs;
                                                          bottomSheetController
                                                                  .contentController
                                                                  .text =
                                                              bottomSheetController
                                                                  .lectures[
                                                                      index]
                                                                  .times
                                                                  .map((e) =>
                                                                      e.place)
                                                                  .toSet()
                                                                  .join(", ");
                                                        },
                                                        child: Flex(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          direction:
                                                              Axis.horizontal,
                                                          children: [
                                                            Flexible(
                                                              flex: 8,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Text(
                                                                    bottomSheetController
                                                                        .lectures[
                                                                            index]
                                                                        .name,
                                                                    style: regularStyle
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                    maxLines: 2,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 4,
                                                                  ),
                                                                  bottomSheetController
                                                                              .lectures[index]
                                                                              .classNumber !=
                                                                          null
                                                                      ? Text(
                                                                          "${bottomSheetController.lectures[index].professor != null ? bottomSheetController.lectures[index].professor! : ""}"
                                                                          "(${bottomSheetController.lectures[index].classNumber!}분반)",
                                                                          style: lightStyle.copyWith(
                                                                              color: Palette.grey,
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      : const SizedBox(),
                                                                  bottomSheetController
                                                                              .lectures[index]
                                                                              .major !=
                                                                          null
                                                                      ? Text(
                                                                          bottomSheetController
                                                                              .lectures[index]
                                                                              .major!
                                                                              .replaceAll(" ", "/"),
                                                                          maxLines:
                                                                              2,
                                                                          style: lightStyle.copyWith(
                                                                              color: Palette.grey,
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      : const SizedBox(),
                                                                  !bottomSheetController
                                                                          .lectures[
                                                                              index]
                                                                          .times
                                                                          .map((e) => e
                                                                              .place)
                                                                          .toList()
                                                                          .contains(
                                                                              null)
                                                                      ? Text(
                                                                          bottomSheetController
                                                                              .lectures[index]
                                                                              .times
                                                                              .map((e) => e.place)
                                                                              .toSet()
                                                                              .join(", ")
                                                                              .toString(),
                                                                          style: lightStyle.copyWith(
                                                                              color: Palette.grey,
                                                                              fontWeight: FontWeight.w500),
                                                                        )
                                                                      : const SizedBox(),
                                                                  const SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Flexible(
                                                              flex: 4,
                                                              child: Column(
                                                                children: [
                                                                  for (ScheduleTime i
                                                                      in bottomSheetController
                                                                          .lectures[
                                                                              index]
                                                                          .times)
                                                                    Text(
                                                                      "${i.week.nameKR} ${i.start}~${i.end}",
                                                                      style: lightStyle
                                                                          .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Divider(
                                                        height: 1,
                                                        color:
                                                            Palette.lightGrey,
                                                      ),
                                                    ],
                                                  );
                                                },
                                              )
                                            : SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child: Text(
                                                    "연관된 강의 목록이 존재하지 않습니다",
                                                    style:
                                                        regularStyle.copyWith(
                                                            color:
                                                                Palette.grey),
                                                  ),
                                                ),
                                              )
                                  ],
                                ),
                              ),
                            ),
                          ],
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
