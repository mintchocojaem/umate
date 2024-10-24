import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:umate/src/core/utils/extensions.dart';
import 'package:umate/src/features/board/presentation/controllers/with_dku/bear_eats/add_bear_eats_post_controller.dart';

import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../design_system/orb/orb.dart';

class AddBearEatsPostScreen extends ConsumerStatefulWidget {
  const AddBearEatsPostScreen({
    super.key,
  });

  @override
  createState() => _AddBearEatsPostScreen();
}

class _AddBearEatsPostScreen extends ConsumerState<AddBearEatsPostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _restaurantController;
  late final TextEditingController _deliveryPlaceController;
  late final TextEditingController _openChatLinkController;
  String deliveryTime = '';

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    _restaurantController = TextEditingController();
    _deliveryPlaceController = TextEditingController();
    _openChatLinkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _bodyController.dispose();
    _restaurantController.dispose();
    _deliveryPlaceController.dispose();
    _openChatLinkController.dispose();

    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDateTime({
    required BuildContext context,
    required bool isStartTime,
  }) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (selectedDate != null && context.mounted) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // 날짜와 시간을 원하는 형식으로 포맷팅
        final String formattedDateTime =
            DateFormat('yyyy-MM-dd HH:mm').format(fullDateTime);

        setState(() {
          deliveryTime = formattedDateTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ref.listen(addBearEatsPostControllerProvider, (prev, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        }
      });

      return OrbScaffold(
        resizeToAvoidBottomInset: true,
        appBar: OrbAppBar(
          title: '게시글 작성',
          centerTitle: true,
          trailing: Wrap(
            children: [
              OrbFilledButton(
                text: '작성',
                disabled: _titleController.text.isEmpty ||
                    _bodyController.text.isEmpty ||
                    _restaurantController.text.isEmpty ||
                    _deliveryPlaceController.text.isEmpty ||
                    deliveryTime.isEmpty,
                buttonType: OrbButtonType.primary,
                buttonSize: OrbButtonSize.compact,
                buttonTextType: OrbButtonTextType.medium,
                buttonRadius: OrbButtonRadius.small,
                onPressed: () async {
                  if (!_openChatLinkController.text
                      .contains('https://open.kakao.com/o/')) {
                    context.showSnackBar(
                      message: '올바른 오픈채팅 링크를 입력해주세요.',
                    );
                    return;
                  }

                  if (!RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$')
                      .hasMatch(deliveryTime)) {
                    context.showSnackBar(
                      message: '주문 시간은 yyyy-MM-dd HH:mm 형식으로 입력해주세요.',
                    );
                    return;
                  }

                  final result = await ref
                      .read(addBearEatsPostControllerProvider.notifier)
                      .addPost(
                          title: _titleController.text,
                          body: _bodyController.text,
                          kakaoOpenChatLink: '',
                          restaurant: _restaurantController.text,
                          deliveryPlace: _deliveryPlaceController.text,
                          deliveryTime: deliveryTime);
                  if (result && context.mounted) {
                    Navigator.of(context).pop();
                    context.showSnackBar(
                      message: '게시글이 작성되었습니다.',
                    );
                  }
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    OrbTextField(
                      focusNode: _titleFocusNode,
                      controller: _titleController,
                      style: OrbTextType.titleSmall,
                      hintText: '제목을 입력해주세요.',
                      maxLength: 100,
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        setState(() {});
                      },
                      fillColor: context.palette.background,
                      boarderColor: context.palette.background,
                    ),
                    const OrbDivider(),
                    OrbTextField(
                      controller: _bodyController,
                      focusNode: _bodyFocusNode,
                      style: OrbTextType.bodyLarge,
                      hintText:
                          '내용을 입력해주세요. \n\n욕설, 비방, 광고, 도배 등의 글은 제재될 수 있으며\n신고 누적시 커뮤니티 이용이 제한됩니다.',
                      maxLines: null,
                      maxLength: 1000,
                      onChanged: (value) {
                        setState(() {});
                      },
                      fillColor: context.palette.background,
                      boarderColor: context.palette.background,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: context.palette.surfaceBright,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: OrbText(
                                    '음식점',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _restaurantController,
                                    style: OrbTextType.bodyMedium,
                                    hintText: '음식점 이름을 입력해주세요(ex: 홍길동 치킨집)',
                                    maxLength: 10,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    textInputAction: TextInputAction.next,
                                    fillColor: Colors.transparent,
                                    boarderColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: OrbText(
                                    '배달 장소',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _deliveryPlaceController,
                                    style: OrbTextType.bodyMedium,
                                    hintText: '배달 장소를 입력해주세요(ex. 단국대 정문)',
                                    maxLength: 50,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    textInputAction: TextInputAction.next,
                                    fillColor: Colors.transparent,
                                    boarderColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: OrbText(
                                    '주문 시간',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    readOnly: true,
                                    controller: TextEditingController(
                                      text: deliveryTime,
                                    ),
                                    style: OrbTextType.bodyMedium,
                                    hintText:
                                        '주문 시간을 입력해주세요(ex. 2024-10-13 18:00)',
                                    maxLength: 50,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    onTap: () async {
                                      await _selectDateTime(
                                        context: context,
                                        isStartTime: true,
                                      );
                                    },
                                    fillColor: Colors.transparent,
                                    boarderColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: OrbText(
                                    '오픈채팅 링크',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _openChatLinkController,
                                    style: OrbTextType.bodyMedium,
                                    hintText:
                                        '카카오톡을 통해 오픈채팅방을 생성 후 링크를 입력해주세요.',
                                    maxLength: 40,
                                    maxLines: 2,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    textInputAction: TextInputAction.next,
                                    fillColor: Colors.transparent,
                                    boarderColor: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      Text(
                        "${_bodyController.text.length}/1000",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
