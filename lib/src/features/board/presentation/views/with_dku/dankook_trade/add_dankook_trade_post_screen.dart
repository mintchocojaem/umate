import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/utils/app_exception.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../controllers/with_dku/dankook_trade/add_dankook_trade_post_controller.dart';

class AddDankookTradePostScreen extends ConsumerStatefulWidget {
  const AddDankookTradePostScreen({
    super.key,
  });

  @override
  createState() => _AddDankookTradePostScreen();
}

class _AddDankookTradePostScreen
    extends ConsumerState<AddDankookTradePostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _priceController;
  late final TextEditingController _tradePlaceController;
  late final TextEditingController _openChatLinkController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  List<XFile> image = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    _priceController = TextEditingController();
    _tradePlaceController = TextEditingController();
    _openChatLinkController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _bodyController.dispose();
    _priceController.dispose();
    _tradePlaceController.dispose();
    _openChatLinkController.dispose();

    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      ref.listen(addDankookTradePostControllerProvider, (pref, next) {
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
                      .read(addDankookTradePostControllerProvider.notifier)
                      .addPost(
                        title: _titleController.text,
                        body: _bodyController.text,
                        price: _priceController.text,
                        tradePlace: _tradePlaceController.text,
                        kakaoOpenChatLink: _openChatLinkController.text,
                        images: image.map((e) => e.path).toList(),
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
                    image.isNotEmpty
                        ? Column(
                            children: [
                              for (final img in image)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          img.path,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            visualDensity:
                                                VisualDensity.compact,
                                            icon: const OrbIcon(
                                              Icons.close_rounded,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                image.remove(img);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ],
                          )
                        : const SizedBox(),
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
                                    '가격',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _priceController,
                                    style: OrbTextType.bodyMedium,
                                    hintText: '가격을 입력해주세요 (ex. 10000)',
                                    maxLength: 10,
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
                                    '거래 장소',
                                    fontWeight: OrbFontWeight.medium,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: OrbTextField(
                                    controller: _tradePlaceController,
                                    style: OrbTextType.bodyMedium,
                                    hintText: '거래 장소를 입력해주세요(ex. 단국대 정문)',
                                    maxLength: 50,
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
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: OrbIcon(
                          Icons.photo,
                          color: context.palette.secondary,
                        ),
                        onPressed: () async {
                          //hide keyboard
                          FocusManager.instance.primaryFocus?.unfocus();
                          final imagePicker = ImagePicker();
                          final pickedImage = await imagePicker
                              .pickImage(source: ImageSource.gallery)
                              .onError((error, stackTrace) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const OrbSnackBar(
                                message: '갤러리를 열 수 없어요.\n(설정에서 권한을 확인해주세요)',
                                type: OrbSnackBarType.error,
                              ),
                            );
                            return null;
                          });
                          if (pickedImage != null) {
                            setState(() {
                              image.add(pickedImage);
                            });
                          }
                        },
                      ),
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
