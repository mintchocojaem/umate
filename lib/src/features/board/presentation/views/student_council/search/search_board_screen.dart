import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../../../design_system/orb/orb.dart';
import '../../../controllers/student_council/search/search_board_controller.dart';
import '../../../widgets/search_board_list.dart';

class SearchBoardScreen extends ConsumerWidget with DateTimeFormatter {
  const SearchBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPost = ref.watch(searchBoardControllerProvider);

    return OrbScaffold(
      appBar: const OrbAppBar(
        title: '게시글 검색',
        centerTitle: true,
      ),
      padding: EdgeInsets.zero,
      disableSafeAreaBottom: true,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            child: OrbSearchBar(
              onSearch: (query) {
                ref
                    .read(searchBoardControllerProvider.notifier)
                    .search(keyword: query);
              },
              onTextChange: (query) {},
            ),
          ),
          Expanded(
            child: searchPost.when(
              skipError: true,
              data: (data) {
                if (data == null) {
                  return const Center(
                    child: OrbText(
                      '검색어를 입력해주세요.',
                      type: OrbTextType.titleSmall,
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchBoardList(
                        title: '공지사항',
                        onTap: (index) {
                          ref.read(routerServiceProvider).pushNamed(
                            AppRoute.noticePost.name,
                            pathParameters: {
                              'id': data.notices.content[index].id.toString(),
                            },
                          );
                        },
                        items: [
                          for (final notice in data.notices.content)
                            SearchBoardItem(
                              title: notice.title,
                              author: notice.author,
                              createdAt: dateFormatToRelative(notice.createdAt),
                              body: notice.body,
                            ),
                        ],
                      ),
                      Container(
                        height: 16,
                        color: context.palette.surfaceBright,
                      ),
                      SearchBoardList(
                        title: '제휴사업',
                        onTap: (index) {
                          ref.read(routerServiceProvider).pushNamed(
                            AppRoute.coalitionPost.name,
                            pathParameters: {
                              'id':
                                  data.coalitions.content[index].id.toString(),
                            },
                          );
                        },
                        items: [
                          for (final coalition in data.coalitions.content)
                            SearchBoardItem(
                              title: coalition.title,
                              author: coalition.author,
                              createdAt:
                                  dateFormatToRelative(coalition.createdAt),
                              body: coalition.body,
                            ),
                        ],
                      ),
                      Container(
                        height: 16,
                        color: context.palette.surfaceBright,
                      ),
                      SearchBoardList(
                        title: '청원게시판',
                        onTap: (index) {
                          ref.read(routerServiceProvider).pushNamed(
                            AppRoute.petitionPost.name,
                            pathParameters: {
                              'id': data.petitions.content[index].id.toString(),
                            },
                          );
                        },
                        items: [
                          for (final petition in data.petitions.content)
                            SearchBoardItem(
                              title: petition.title,
                              author: petition.author,
                              createdAt:
                                  dateFormatToRelative(petition.createdAt),
                              body: petition.body,
                            ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
              loading: () => ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const OrbShimmerContent();
                },
              ),
              error: (error, _) => const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
