import 'package:danvery/app/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralPostPage extends GetView{
  const GeneralPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        title: "게시글",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          Get.back();
        },
        actions: [
          IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.edit,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
