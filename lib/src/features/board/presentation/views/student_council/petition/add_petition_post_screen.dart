import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../controllers/student_council/petition/add_petition_post_controller.dart';

class AddPetitionPostScreen extends ConsumerStatefulWidget {
  const AddPetitionPostScreen({
    super.key,
  });

  @override
  createState() => _AddPetitionPostScreen();
}

class _AddPetitionPostScreen extends ConsumerState<AddPetitionPostScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;

  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _bodyFocusNode = FocusNode();

  List<XFile> image = [];
  FilePickerResult? file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _bodyController.dispose();

    _titleFocusNode.dispose();
    _bodyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrbScaffold(
      resizeToAvoidBottomInset: true,
      appBar: OrbAppBar(
        title: '청원 작성',
        centerTitle: true,
        onAutoImplyLeadingPressed: () {
          ref.read(routerServiceProvider).pop();
        },
        trailing: Wrap(
          children: [
            OrbFilledButton(
              text: '작성',
              disabled:
                  _titleController.text.isEmpty || _bodyController.text.isEmpty,
              buttonType: OrbButtonType.primary,
              buttonSize: OrbButtonSize.compact,
              buttonTextType: OrbButtonTextType.medium,
              buttonRadius: OrbButtonRadius.small,
              onPressed: () async {
                final result = await ref
                    .read(addpetitionPostControllerProvider.notifier)
                    .writePetition(
                  title: _titleController.text,
                  body: _bodyController.text,
                  images: image.map((e) => e.path).toList(),
                  files: [
                    if (file != null) file!.xFiles.single.path,
                  ],
                );

                if (result) {
                  ref.read(routerServiceProvider).pop();
                  if (!context.mounted) return;
                  context.showSnackBar(
                    message: '청원이 작성되었습니다.',
                  );
                }
              },
            ),
          ],
        ),
      ),
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
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
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              file != null
                  ? Container(
                      color: context.palette.surfaceBright,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              child: Row(
                                children: [
                                  const OrbIcon(
                                    Icons.attachment_rounded,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: OrbText(
                                      file!.files.first.name,
                                    ),
                                  ),
                                ],
                              ),
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
                                visualDensity: VisualDensity.compact,
                                icon: const OrbIcon(
                                  Icons.close_rounded,
                                ),
                                onPressed: () {
                                  setState(() {
                                    file = null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
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
                    const SizedBox(
                      width: 8,
                    ),
                    IconButton(
                      icon: OrbIcon(
                        Icons.attachment_rounded,
                        color: context.palette.secondary,
                      ),
                      onPressed: () async {
                        //hide keyboard
                        FocusManager.instance.primaryFocus?.unfocus();

                        final pickedFile = await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: [
                            'pdf',
                            'doc',
                            'docx',
                            'ppt',
                            'pptx',
                          ],
                        );
                        if (pickedFile != null) {
                          setState(() {
                            file = pickedFile;
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
  }
}
