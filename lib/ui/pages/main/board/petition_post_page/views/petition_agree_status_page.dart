import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/controller/petition_post_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class PetitionAgreeStatusPage extends GetView<PetitionPostPageController> {
  const PetitionAgreeStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "청원 동의 현황",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          Get.back();
        },
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Obx(
          () => controller.isLoadedPetitionPost.value
              ? Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Stack(
                        children: [
                          PieChart(
                            PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {},
                                ),
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: 0,
                                centerSpaceRadius: 60,
                                sections: showingSections()),
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                '${controller.petitionPost.value.agreeCount} 명',
                                style: bigTitleStyle.copyWith(
                                    color: Palette.darkGrey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              '청원의 동의 비율은\n 상위 4개의 학과만 볼 수 있습니다',
                              textAlign: TextAlign.center,
                              style: lightStyle.copyWith(
                                color: Palette.darkGrey,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Divider(
                              thickness: 1,
                              color: Palette.lightGrey,
                            ),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    controller.petitionPost.value.agreeCount,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: Text(
                                      '${index + 1}.',
                                      style: regularStyle.copyWith(
                                        color: Palette.black,
                                      ),
                                    ),
                                    title: Text(
                                      controller.petitionPost.value
                                          .statisticList[index].department,
                                      style: regularStyle.copyWith(
                                        color: Palette.darkGrey,
                                      ),
                                    ),
                                    trailing: Text(
                                      '(${(controller.petitionPost.value.statisticList[index].agreeCount
                                          / controller.petitionPost.value.agreeCount * 100).round()}%) '
                                      '${controller.petitionPost.value.statisticList[index].agreeCount}명',
                                      style: regularStyle.copyWith(
                                        color: Palette.darkGrey,
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final agreeCount = controller.petitionPost.value.agreeCount;

    return List.generate(agreeCount, (i) {
      const radius = 100.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Palette.darkBlue,
            value: controller.petitionPost.value.statisticList[0].agreeCount /
                agreeCount *
                100,
            title:
                '${(controller.petitionPost.value.statisticList[0].agreeCount / agreeCount * 100).round()}%\n'
                ' ${controller.petitionPost.value.statisticList[0].department}',
            radius: radius,
            titleStyle: regularStyle.copyWith(color: Palette.pureWhite),
          );
        case 1:
          return PieChartSectionData(
            color: Palette.blue,
            value: controller.petitionPost.value.statisticList[1].agreeCount /
                agreeCount *
                100,
            title:
                '${(controller.petitionPost.value.statisticList[1].agreeCount / agreeCount * 100).round()}%\n'
                ' ${controller.petitionPost.value.statisticList[1].department}',
            radius: radius,
            titleStyle: regularStyle.copyWith(color: Palette.pureWhite),
          );
        case 2:
          return PieChartSectionData(
            color: Palette.lightBlue,
            value: controller.petitionPost.value.statisticList[2].agreeCount /
                agreeCount *
                100,
            title:
                '${(controller.petitionPost.value.statisticList[2].agreeCount / agreeCount * 100).round()}%\n'
                ' ${controller.petitionPost.value.statisticList[2].department}',
            radius: radius,
            titleStyle: regularStyle.copyWith(color: Palette.pureWhite),
          );
        case 3:
          return PieChartSectionData(
            color: Palette.sky,
            value: controller.petitionPost.value.statisticList[3].agreeCount /
                agreeCount *
                100,
            title:
                '${(controller.petitionPost.value.statisticList[3].agreeCount / agreeCount * 100).round()}%\n'
                ' ${controller.petitionPost.value.statisticList[3].department}',
            radius: radius,
            titleStyle: regularStyle.copyWith(color: Palette.pureWhite),
          );
        case 4:
          return PieChartSectionData(
            color: Palette.mint,
            value: controller.petitionPost.value.statisticList[4].agreeCount /
                agreeCount *
                100,
            title:
                '${(controller.petitionPost.value.statisticList[4].agreeCount / agreeCount * 100).round()}%\n'
                ' ${controller.petitionPost.value.statisticList[4].department}',
            radius: radius,
            titleStyle: regularStyle.copyWith(color: Palette.pureWhite),
          );
        default:
          throw Error();
      }
    });
  }
}
