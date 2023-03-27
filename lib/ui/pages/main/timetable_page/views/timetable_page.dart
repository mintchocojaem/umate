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
              openBottomSheet();
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
            Timetable(
              subjects: [
                SubjectModel(
                    name: "사업개발과경영",
                    startTime: '09:00',
                    endTime: '10:00',
                    days: ["월", "화"]),
                SubjectModel(
                    name: "생활속의뇌이야기",
                    startTime: '11:00',
                    endTime: '13:00',
                    days: ["수"]),
              ],
              tableStartTime: 9,
              tableEndTime: 18,
              today: DateTime.now().weekday -1,
            ),
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

  void openBottomSheet() {
    Get.bottomSheet(
      SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        //close bottom sheet
                      },
                      icon: Icon(
                        Icons.close,
                        color: Palette.blue,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "추가",
                        style: regularStyle.copyWith(color: Palette.blue),
                      ),
                    ),
                  ],
                ),
                ModernFormField(
                  hint: "제목",
                ),
                SizedBox(height: 8),
                Flex(
                  direction: Axis.horizontal,
                  children: const [
                    Flexible(
                      flex: 5,
                      child: ModernFormField(
                        hint: "요일",
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 6,
                      child: ModernFormField(
                        hint: "시작 시간",
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      flex: 6,
                      child: ModernFormField(
                        hint: "종료 시간",
                        suffixIcon: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                ModernFormField(
                  hint: "장소",
                ),
                SizedBox(height: 16),
                ColorPicker(
                  colors: [
                    Colors.blue,
                    Colors.red,
                    Colors.green,
                    Colors.yellow,
                    Colors.purple,
                    Colors.orange,
                    Colors.pink,
                    Colors.brown,
                    Colors.grey,
                    Colors.black,
                  ],
                  onColorSelected: (color) {
                    controller.selectedColor = color;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      enableDrag: false,
      backgroundColor: Palette.pureWhite,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        )
      ),
    );
  }
}
