import 'package:danvery/domain/board/board_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/screens/main/board/widgets/petition_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../routes/route_name.dart';

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _BoardScreen();
  }
}

class _BoardScreen extends ConsumerState<BoardScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await ref.read(boardProvider.notifier).getPetitionBoard();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      defaultAppBar: false,
      shrinkWrap: true,
      scrollBody: false,
      body: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '검색',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              counterText: '',
            ),
            maxLines: 1,
            maxLength: 50,
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: ref.watch(boardProvider).when(
              data: (posts) {
                final postList = posts!.content;
                return RefreshIndicator(
                  color: themeData.colorScheme.primary,
                  onRefresh: () {
                    return ref
                        .read(boardProvider.notifier)
                        .getPetitionBoard(firstPage: true);
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      final post = postList[index];
                      final createdAt = DateFormat("yy.MM.dd")
                          .format(DateTime.parse(post.createdAt));
                      final expiresAt = DateFormat("yy.MM.dd")
                          .format(DateTime.parse(post.createdAt));
                      final today = DateTime.now();
                      final remainingDate = today
                              .isAfter(DateTime.parse(post.expiresAt))
                          ? "마감"
                          : "${today.difference(DateTime.parse(post.createdAt)).inDays}일 남음";
                      final duration = "$createdAt ~ $expiresAt";
                      final status = switch (post.status) {
                        "ACTIVE" => "청원 중",
                        "WAITING" => "대기 중",
                        "ANSWERED" => "답변 완료",
                        "EXPIRED" => "기간 만료",
                        String() => "알 수 없음",
                      };
                      if (index == postList.length - 1) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: PetitionCard(
                                remainingDate: remainingDate,
                                title: post.title,
                                duration: duration,
                                agreeCount: post.agreeCount,
                                status: status,
                                onTap: () {
                                  ref.read(routerProvider).push(RouteName.post);
                                },
                              ),
                            ),
                            const OrbShimmerContent(),
                          ],
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: PetitionCard(
                          remainingDate: remainingDate,
                          title: post.title,
                          duration: duration,
                          agreeCount: post.agreeCount,
                          status: status,
                          onTap: () {
                            ref.read(routerProvider).push(RouteName.post);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [OrbShimmerContent(), OrbDivider()],
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [OrbShimmerContent(), OrbDivider()],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
