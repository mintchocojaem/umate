import 'package:danvery/domain/board/post/petition_post/controller/petition_post_controller.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/controller/petition_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../utils/theme/app_text_theme.dart';
import '../../../../../../utils/theme/palette.dart';
import '../../../../../widgets/app_bar/transparent_app_bar.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class PetitionPostPage extends GetView<PetitionPostPageController> {
  const PetitionPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "청원게시판",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          Get.back();
        },
        actions: [

        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Obx(
                    () => controller.isLoadedPetitionPost
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "[학생복지]",
                                style: tinyStyle.copyWith(color: Palette.lightBlue),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.petitionPostModel.title,
                                    style: regularStyle.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 10,
                                        child: Row(
                                          children: [
                                            Text(
                                              "청원기간",
                                              style: lightStyle.copyWith(
                                                  color: Palette.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 4,),
                                            Text(
                                              "${controller.petitionPostModel.createdAt.substring(0, 10)} ~ ${controller.petitionPostModel.expiresAt}",
                                              style: lightStyle.copyWith(
                                                  color: Palette.grey, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Text(
                                              "청원상태",
                                              style: lightStyle.copyWith(
                                                  color: Palette.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 4,),
                                            Text(
                                              controller.petitionPostModel.status,
                                              style: lightStyle.copyWith(
                                                  color: Palette.blue, fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Divider(
                                    color: Palette.grey,
                                    height: 1,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Text(
                                    controller.petitionPostModel.body,
                                    style: regularStyle,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Palette.white,
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    width: 128,
                                    height: 128,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Palette.white,
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    width: 128,
                                    height: 128,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  Text("참여인원", style: regularStyle.copyWith(fontWeight: FontWeight.bold, color: Palette.darkGrey),),
                                  const SizedBox(width: 8,),
                                  Text("0명", style: regularStyle.copyWith(fontWeight: FontWeight.bold, color: Palette.blue),),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Divider(
                                color: Palette.grey,
                                height: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "단과대",
                                            style: regularStyle.copyWith(
                                                color: Palette.darkGrey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Text(
                                            "동의합니다.",
                                            style: regularStyle,
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "01/15 12:39",
                                            style:
                                            tinyStyle.copyWith(color: Palette.grey),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Divider(
                                    color: Palette.grey,
                                    height: 1,
                                  ),
                                ],
                              )
                            ],
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ModernFormButton(
                onPressed: () {

                },
                text: '동의하기',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
