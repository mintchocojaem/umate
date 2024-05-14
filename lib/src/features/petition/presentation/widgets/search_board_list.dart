import 'package:flutter/material.dart';

import '../../../../design_system/orb/orb.dart';

class SearchBoardItem {
  final String title;
  final String author;
  final String createdAt;
  final String body;

  const SearchBoardItem({
    required this.title,
    required this.author,
    required this.createdAt,
    required this.body,
  });
}

class SearchBoardList extends StatefulWidget {
  final String title;

  final List<SearchBoardItem> items;
  final void Function(int index) onTap;

  const SearchBoardList({
    super.key,
    required this.title,
    required this.items,
    required this.onTap,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchBoardListState();
  }
}

class _SearchBoardListState extends State<SearchBoardList> {
  int currentShowingItem = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentShowingItem = widget.items.length > 5 ? 5 : widget.items.length;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          OrbText(
            widget.title,
            type: OrbTextType.titleSmall,
          ),
          const SizedBox(height: 16),
          if (widget.items.isEmpty) const SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OrbText(
                          "연관된 게시글이 존재하지 않아요",
                          type: OrbTextType.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ) else Column(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentShowingItem,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            widget.onTap(index);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: index == 0 ? 0 : 24,
                              ),
                              InkWell(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        OrbText(
                                          widget.items[index].author,
                                          type: OrbTextType.bodySmall,
                                          fontWeight: OrbFontWeight.medium,
                                        ),
                                        const SizedBox(width: 8),
                                        OrbText(
                                          widget.items[index].createdAt,
                                          type: OrbTextType.bodySmall,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    OrbText(
                                      widget.items[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    OrbText(
                                      widget.items[index].body,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: OrbFontWeight.light,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              const OrbDivider(),
                            ],
                          ),
                        );
                      },
                    ),
                    currentShowingItem == widget.items.length
                        ? const SizedBox(height: 24)
                        : const SizedBox(height: 0),
                    if (currentShowingItem < widget.items.length)
                      InkWell(
                        onTap: () {
                          setState(() {
                            currentShowingItem +=
                                widget.items.length - currentShowingItem;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: OrbText(
                            "${widget.items.length - currentShowingItem}개 더 보기",
                            type: OrbTextType.bodyLarge,
                          ),
                        ),
                      ),
                  ],
                ),
        ],
      ),
    );
  }
}
