import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/app_exception.dart';
import '../../../../design_system/orb/orb.dart';
import '../controllers/add_lecture_controller.dart';
import '../widgets/lecture_info_card.dart';
import '../widgets/lecture_info_preview_card.dart';
import '../widgets/schedule_color_picker.dart';

class AddLectureScreen extends ConsumerStatefulWidget {
  const AddLectureScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _AddLectureScreenState();
  }
}

class _AddLectureScreenState extends ConsumerState<AddLectureScreen> {
  final keywordController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final ValueNotifier<bool> onSearch = ValueNotifier(false);

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final lectureInfos = ref.watch(addLectureControllerProvider);

    ref.listen(
      addLectureControllerProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        }
      },
    );

    return OrbScaffold(
      disableSafeAreaBottom: true,
      appBar: OrbAppBar(
        title: '수업 추가',
        centerTitle: true,
        onAutoImplyLeadingPressed: () {
          ref.read(routerServiceProvider).pop();
        },
      ),
      body: Column(
        children: [
          OrbSearchBar(
            focusNode: focusNode,
            textController: keywordController,
            onTextChange: (query) {
              onSearch.value = false;
              ref.read(addLectureControllerProvider.notifier).search(
                    keyword: query,
                    isTyping: true,
                  );
            },
            onSearch: (query) {
              onSearch.value = true;
              ref.read(addLectureControllerProvider.notifier).search(
                    keyword: query,
                  );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: lectureInfos.when(
              skipError: true,
              data: (data) {
                if (data == null) {
                  return const Center(
                    child: OrbText(
                      '검색어를 입력해주세요.',
                      type: OrbTextType.titleSmall,
                    ),
                  );
                } else if (data.isEmpty) {
                  return const Center(
                    child: OrbText(
                      '검색 결과가 없습니다.',
                      type: OrbTextType.titleSmall,
                    ),
                  );
                }

                return ValueListenableBuilder(
                  valueListenable: onSearch,
                  builder: (context, value, child) {
                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (!value) {
                            return LectureInfoPreviewCard(
                              title: data[index].name,
                              onPressed: () {
                                onSearch.value = true;
                                keywordController.text = data[index].name;
                                ref
                                    .read(addLectureControllerProvider.notifier)
                                    .search(
                                      keyword: data[index].name,
                                    );
                              },
                            );
                          }
                          return LectureInfoCard(
                            lectureInfo: data[index],
                            onPressedAdd: () async {
                              final result = await ref
                                  .read(addLectureControllerProvider.notifier)
                                  .addLecture(
                                    name: data[index].name,
                                    professor: data[index].professor,
                                    color: ScheduleColorPicker.colors[Random()
                                        .nextInt(
                                            ScheduleColorPicker.colors.length)],
                                    times: data[index].times,
                                  );

                              if (!context.mounted) return;

                              if (result) {
                                context.showSnackBar(
                                  message: '일정이 추가되었습니다.',
                                );
                                ref.read(routerServiceProvider).pop();
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
              loading: () => ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const OrbShimmerContent();
                },
              ),
              error: (error, stackTrace) {
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
