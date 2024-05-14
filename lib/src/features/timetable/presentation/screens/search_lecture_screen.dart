import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/schedule.dart';
import '../../domain/models/schedule_type.dart';
import '../../timetable_dependency_injections.dart';
import '../providers/states/schedule_state.dart';
import '../providers/states/search_lecture_state.dart';
import '../widgets/lecture_info_card.dart';
import '../widgets/lecture_info_preview_card.dart';
import '../widgets/schedule_color_picker.dart';

class SearchLectureScreen extends ConsumerStatefulWidget {
  final int startHour;
  final int endHour;

  const SearchLectureScreen({
    super.key,
    required this.startHour,
    required this.endHour,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SearchLectureScreenState();
  }
}

class _SearchLectureScreenState extends ConsumerState<SearchLectureScreen> {
  final FocusNode focusNode = FocusNode();

  final keywordController = TextEditingController();

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

    ref.listen(
      scheduleProvider,
      (prev, next) async {
        if (next is ScheduleFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is ScheduleSuccessState) {
          ref.read(routerServiceProvider).pop();
        }
      },
    );

    final timetableAddLectureState = ref.watch(searchLectureProvider);

    return OrbScaffold(
      disableSafeAreaBottom: true,
      appBar: const OrbAppBar(
        title: '수업 추가',
        centerTitle: true,
      ),
      body: Column(
        children: [
          OrbSearchBar(
            focusNode: focusNode,
            textController: keywordController,
            onSearch: (query) {
              ref.read(searchLectureProvider.notifier).searchLecture(
                    keyword: query,
                  );
            },
            onTextChange: (query) {
              ref.read(searchLectureProvider.notifier).isTyping(
                    keyword: query,
                  );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: switch (timetableAddLectureState) {
              SearchLectureInitialState _ => const Center(
                  child: OrbText(
                    '검색어를 입력해주세요.',
                    type: OrbTextType.titleSmall,
                  ),
                ),
              SearchLectureLoadingState _ => ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const OrbShimmerContent();
                  },
                ),
              SearchLectureIsTypingState result => SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: result.lectureNames.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return LectureInfoPreviewCard(
                        title: result.lectureNames[index],
                        onPressed: () {
                          keywordController.text = result.lectureNames[index];
                          ref
                              .read(searchLectureProvider.notifier)
                              .searchLecture(
                                keyword: result.lectureNames[index],
                              );
                        },
                      );
                    },
                  ),
                ),
              SearchLectureOnSearchState result => result.lectures.isNotEmpty
                  ? SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: result.lectures.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return LectureInfoCard(
                            lectureInfo: result.lectures[index],
                            onPressedAdd: () {
                              ref.read(scheduleProvider.notifier).addSchedule(
                                    schedule: Schedule(
                                      name: result.lectures[index].lectureName,
                                      type: ScheduleType.lecture,
                                      professor:
                                          result.lectures[index].professor,
                                      memo: '',
                                      color: ScheduleColorPicker.colors[Random()
                                          .nextInt(ScheduleColorPicker
                                              .colors.length)],
                                      times:
                                          result.lectures[index].scheduleTimes,
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    )
                  : const Center(
                      child: OrbText(
                        '검색 결과가 없습니다.',
                        type: OrbTextType.titleSmall,
                      ),
                    ),
            },
          ),
        ],
      ),
    );
  }
}
