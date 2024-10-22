import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/app_exception.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../design_system/orb/orb.dart';
import '../../../controllers/with_dku/dantudy/add_dantudy_post_controller.dart';

class AddDantudyPostScreen extends ConsumerStatefulWidget {
  const AddDantudyPostScreen({
    super.key,
  });

  @override
  createState() => _AddDantudyPostScreen();
}

class _AddDantudyPostScreen extends ConsumerState<AddDantudyPostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _minStudentIdController;
  late final TextEditingController _tagController;
  late final TextEditingController _startTimeController;
  late final TextEditingController _endTimeController;
  late final TextEditingController _openChatLinkController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    _minStudentIdController = TextEditingController();
    _tagController = TextEditingController();
    _startTimeController = TextEditingController();
    _endTimeController = TextEditingController();
    _openChatLinkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _bodyController.dispose();
    _minStudentIdController.dispose();
    _tagController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _openChatLinkController.dispose();

    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ref.listen(addDantudyPostControllerProvider, (pref, next) {
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
                    _bodyController.text.isEmpty,
                buttonType: OrbButtonType.primary,
                buttonSize: OrbButtonSize.compact,
                buttonTextType: OrbButtonTextType.medium,
                buttonRadius: OrbButtonRadius.small,
                onPressed: () async {
                  if (!_minStudentIdController.text
                      .contains(RegExp(r'^\d{2}$'))) {
                    context.showSnackBar(
                      message: '올바른 학번을 입력해주세요.(ex. 19)',
                    );
                    return;
                  }

                  if (!_startTimeController.text
                      .contains(RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$'))) {
                    context.showSnackBar(
                      message: '올바른 시작 시간을 입력해주세요.(ex. 2023-01-01 14:00)',
                    );
                    return;
                  }

                  if (!_endTimeController.text
                      .contains(RegExp(r'^\d{4}-\d{2}-\d{2} \d{2}:\d{2}$'))) {
                    context.showSnackBar(
                      message: '올바른 종료 시간을 입력해주세요.(ex. 2023-01-01 16:00)',
                    );
                    return;
                  }

                  if (!_openChatLinkController.text
                      .contains('https://open.kakao.com/o/')) {
                    context.showSnackBar(
                      message: '올바른 오픈채팅 링크를 입력해주세요.',
                    );
                    return;
                  }

                  final result = await ref
                      .read(addDantudyPostControllerProvider.notifier)
                      .addPost(
                        title: _titleController.text,
                        body: _bodyController.text,
                        minStudentId: int.parse(_minStudentIdController.text),
                        tag: _tagController.text,
                        kakoOpenChatLink: _openChatLinkController.text,
                        startTime: _startTimeController.text,
                        endTime: _endTimeController.text,
                      );

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
                                    '최소학번',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _minStudentIdController,
                                    style: OrbTextType.bodyMedium,
                                    hintText: '최소학번을 입력해주세요 (ex. 19)',
                                    maxLength: 2,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    keyboardType: TextInputType.number,
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
                                    '태그',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _tagController,
                                    style: OrbTextType.bodyMedium,
                                    hintText: '태그를 입력해주세요 (ex. 프로그래밍)',
                                    maxLength: 20,
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
                                    '시작 시간',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _startTimeController,
                                    style: OrbTextType.bodyMedium,
                                    hintText:
                                        '스터디 시작 시간을 입력해주세요 (ex. 2023-01-01 14:00)',
                                    maxLength: 30,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    textInputAction: TextInputAction.done,
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
                                    '종료 시간',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _endTimeController,
                                    style: OrbTextType.bodyMedium,
                                    hintText:
                                        '스터디 종료 시간을 입력해주세요 (ex. 2023-01-01 16:00)',
                                    maxLength: 30,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    textInputAction: TextInputAction.done,
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
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: OrbText(
                "${_bodyController.text.length}/1000",
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    });
  }
}
