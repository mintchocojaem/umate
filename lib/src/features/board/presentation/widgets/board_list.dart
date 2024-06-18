import 'package:flutter/material.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/board.dart';
import '../../domain/models/post.dart';
import '../../domain/models/post_sort.dart';

class BoardList<P extends Post> extends StatelessWidget with DateTimeFormatter {
  final Board<P> board;
  final Widget Function(int index) postItems;
  final List<PostSort> sortList;

  BoardList({
    super.key,
    required this.board,
    required this.sortList,
    required this.postItems,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      clipBehavior: Clip.none,
      shrinkWrap: true,
      itemCount: (board.content.length + 1),
      itemBuilder: (context, index) {
        if (index == board.content.length && board.hasNext) {
          return const OrbShimmerContent();
        } else if (index == board.content.length) {
          return const SizedBox();
        }
        if (index == 0 && sortList.isNotEmpty) {
          return Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OrbText(
                          "전체 ${board.totalElements}",
                          type: OrbTextType.bodyMedium,
                        ),
                        DropdownButton(
                          underline: const SizedBox(),
                          value: sortList.first,
                          items: [
                            for (final sort in sortList)
                              DropdownMenuItem(
                                value: sort,
                                child: OrbText(
                                  sort.type.displayName,
                                  type: OrbTextType.bodyMedium,
                                ),
                              ),
                          ],
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              postItems(index),
            ],
          );
        }
        return postItems(index);
      },
    );
  }
}
