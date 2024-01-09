import 'package:danvery/domain/board/board_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/board/post/petition_provider.dart';

class PetitionWriteScreen extends ConsumerStatefulWidget {
  const PetitionWriteScreen({
    super.key,
  });

  @override
  createState() => _PetitionWriteScreen();
}

class _PetitionWriteScreen extends ConsumerState<PetitionWriteScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final GlobalKey<FormState> _formKey;

  XFile? image;
  FilePickerResult? file;

  @override
  void initState() {
    // TODO: implement initState
    _formKey = GlobalKey<FormState>();
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      scrollBody: false,
      bottomPadding: false,
      orbAppBar: OrbAppBar(
        title: '청원 게시글',
        centerTitle: true,
        trailing: OrbButton(
          buttonText: '올리기',
          buttonSize: OrbButtonSize.compact,
          buttonRadius: OrbButtonRadius.small,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await ref
                  .read(petitionWriteProvider)
                  .writePetitionPost(
                    title: _titleController.text,
                    body: _bodyController.text,
                    image: image,
                    file: file,
                  )
                  .then((value) {
                if (value) {
                  ref.invalidate(petitionStatusProvider);
                  ref.read(boardProvider.notifier).getPetitionBoard(refresh: true).whenComplete(() {
                    Navigator.of(context).pop(true);
                    OrbSnackBar.show(
                      message: '청원 게시글이 등록되었습니다.',
                      type: OrbSnackBarType.info,
                    );
                  });
                }
              });
            }
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            OrbTextFormField(
              controller: _titleController,
              hintText: '제목을 입력해주세요.',
              textInputAction: TextInputAction.next,
              inputTextStyle: themeData.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return '제목을 입력해주세요.';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 4,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    OrbTextFormField(
                      controller: _bodyController,
                      hintText: '내용을 입력해주세요.',
                      textInputAction: TextInputAction.done,
                      maxLines: null,
                      enabledBoarderColor: Colors.transparent,
                      focusedBoarderColor: Colors.transparent,
                      maxLength: 1000,
                      onChanged: (value) {
                        ref
                            .read(petitionContentLengthProvider.notifier)
                            .update((state) => value.length);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '내용을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    image!.path,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: themeData.colorScheme.surface,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: themeData.colorScheme.onSurface,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          image = null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                    file != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 16),
                                    color: themeData.colorScheme.surface,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.attachment_rounded,
                                          color:
                                              themeData.colorScheme.onSurface,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            file!.files.first.name,
                                            style: themeData.textTheme.bodyMedium?.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                            )
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
                                    decoration: BoxDecoration(
                                      color: themeData.colorScheme.surface,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      visualDensity: VisualDensity.compact,
                                      icon: Icon(
                                        Icons.close_rounded,
                                        color: themeData.colorScheme.onSurface,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      customSubmitButton: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 4,
          top: 4,
          left: 8,
          right: 24,
        ),
        color: themeData.colorScheme.surface,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.photo,
                color: themeData.colorScheme.onSurface,
              ),
              onPressed: () async {
                final imagePicker = ImagePicker();
                final pickedImage =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (pickedImage != null) {
                  setState(() {
                    image = pickedImage;
                  });
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.attachment_rounded,
                color: themeData.colorScheme.onSurface,
              ),
              onPressed: () async {
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
              "${ref.watch(petitionContentLengthProvider)}/1000",
              style: themeData.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
