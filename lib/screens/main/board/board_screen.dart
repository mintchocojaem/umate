import 'package:danvery/domain/board/board_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/screens/main/board/widgets/petition_card.dart';
import 'package:danvery/screens/main/board/widgets/petition_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../routes/route_path.dart';

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  createState() => _BoardScreen();
}

class _BoardScreen extends ConsumerState {
  final ScrollController _controller = ScrollController();

  late double initialTopBarSize; // PetitionStatusBar()의 최대 높이
  late double topContainerHeight; // 원하는 초기 높이값 설정
  late final double minTopContainerHeight; // 최소 높이값 설정
  late final double scrollSpeed;

  @override
  void initState() {
    super.initState();
    initialTopBarSize = 64;
    topContainerHeight = initialTopBarSize;
    minTopContainerHeight = 0;
    scrollSpeed = 5;
    _controller.addListener(() async{
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (topContainerHeight > minTopContainerHeight) {
          setState(() {
            topContainerHeight -= scrollSpeed;
            if (topContainerHeight < minTopContainerHeight) {
              topContainerHeight = minTopContainerHeight;
            }
          });
        }
      }

      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (topContainerHeight < initialTopBarSize) {
          setState(() {
            topContainerHeight += scrollSpeed;
            if (topContainerHeight > initialTopBarSize) {
              topContainerHeight = initialTopBarSize;
            }
          });
        }
      }

      if (_controller.position.pixels ==
          _controller.position.maxScrollExtent) {
        await ref.read(boardProvider.notifier).getPetitionBoard();
      }

    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
          SizedBox(
            height: topContainerHeight,
            child: PetitionStatusBar(),
          ),
          Expanded(
            child: ref.watch(boardProvider).when(
              data: (posts) {
                final petitions = posts!.content;
                return RefreshIndicator(
                  color: themeData.colorScheme.primary,
                  onRefresh: () {
                    return ref
                        .read(boardProvider.notifier)
                        .getPetitionBoard(firstPage: true);
                  },
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: petitions.length,
                    itemBuilder: (context, index) {
                      final petition = petitions[index];
                      final createdAt = DateFormat("yy.MM.dd")
                          .format(DateTime.parse(petition.createdAt));
                      final expiresAt = DateFormat("yy.MM.dd")
                          .format(DateTime.parse(petition.createdAt));
                      final today = DateTime.now();
                      final remainingDate = today
                              .isAfter(DateTime.parse(petition.expiresAt))
                          ? "마감"
                          : "${today.difference(DateTime.parse(petition.createdAt)).inDays}일 남음";
                      final duration = "$createdAt ~ $expiresAt";
                      final status = switch (petition.status) {
                        "ACTIVE" => "청원 중",
                        "WAITING" => "대기 중",
                        "ANSWERED" => "답변 완료",
                        "EXPIRED" => "기간 만료",
                        String() => "알 수 없음",
                      };
                      final Widget petitionCard = Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: PetitionCard(
                          remainingDate: remainingDate,
                          title: petition.title,
                          duration: duration,
                          agreeCount: petition.agreeCount,
                          status: status,
                          onTap: () {
                            ref.read(routerProvider).push(
                                  RouteInfo.petition.fullPath,
                                  extra: petition.id,
                                );
                          },
                        ),
                      );
                      if (index == petitions.length - 1) {
                        return Column(
                          children: [
                            petitionCard,
                            const OrbShimmerContent(),
                          ],
                        );
                      }
                      return petitionCard;
                    },
                  ),
                );
              },
              loading: () {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        OrbShimmerContent(),
                        OrbDivider(),
                      ],
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        OrbShimmerContent(),
                        OrbDivider(),
                      ],
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
