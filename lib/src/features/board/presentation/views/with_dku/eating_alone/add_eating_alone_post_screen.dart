import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../controllers/with_dku/eating_alone/add_eating_alone_post_controller.dart';

class AddEatingAlonePostScreen extends ConsumerStatefulWidget {
  const AddEatingAlonePostScreen({
    super.key,
  });

  @override
  createState() => _AddEatingAlonePostScreen();
}

class _AddEatingAlonePostScreen
    extends ConsumerState<AddEatingAlonePostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _openChatLinkController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    _openChatLinkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _bodyController.dispose();
    _openChatLinkController.dispose();

    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ref.listen(addEatingAlonePostControllerProvider, (pref, next) {
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
                  if (!_openChatLinkController.text
                      .contains('https://open.kakao.com/o/')) {
                    context.showSnackBar(
                      message: '올바른 오픈채팅 링크를 입력해주세요.',
                    );
                    return;
                  }

                  final result = await ref
                      .read(addEatingAlonePostControllerProvider.notifier)
                      .addPost(
                        title: _titleController.text,
                        body: _bodyController.text,
                        kakaoOpenChatLink: _openChatLinkController.text,
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
