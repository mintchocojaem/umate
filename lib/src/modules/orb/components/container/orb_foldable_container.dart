import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FoldableScrollController {
  final ScrollController scrollController;
  final double minHeight; // 최소 높이값 설정
  final double maxHeight; // 최대 높이값 설정
  final double height;
  final double scrollSpeed;

  late double containerHeight;

  FoldableScrollController({
    required this.scrollController,
    this.minHeight = 0,
    required this.height,
    required this.maxHeight,
    this.scrollSpeed = 5,
  }) : containerHeight = height {
    init();
  }

  void init() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (containerHeight > minHeight) {
          containerHeight -= scrollSpeed;
          if (containerHeight < minHeight) {
            containerHeight = minHeight;
          }
        }
      }

      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (containerHeight < maxHeight) {
          containerHeight += scrollSpeed;
          if (containerHeight > maxHeight) {
            containerHeight = maxHeight;
          }
        }
      }
    });
  }

  void addListener(OnScroll onScroll) {
    scrollController.addListener(() {
      onScroll.call(scrollController.position);
    });
  }

  void dispose() {
    scrollController.dispose();
  }

  void initScrollPosition({VoidCallback? callback}) {
    if(scrollController.hasClients){
      scrollController.jumpTo(0);
      callback?.call();
    }
    containerHeight = height;
  }
}

typedef OnScroll = void Function(ScrollPosition position);

class OrbFoldableContainer extends StatefulWidget {
  final FoldableScrollController scrollController;
  final Widget? child;
  final OnScroll? onScroll;

  const OrbFoldableContainer({
    super.key,
    required this.scrollController,
    this.child,
    this.onScroll,
  });

  @override
  createState() => _OrbFoldableContainer();
}

class _OrbFoldableContainer extends State<OrbFoldableContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    widget.scrollController.addListener((position) {
      setState(() {
        if (widget.onScroll != null) {
          widget.onScroll!.call(position);
        }
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.scrollController.containerHeight,
      child: Opacity(
        opacity: (widget.scrollController.containerHeight -
                widget.scrollController.minHeight) /
            widget.scrollController.maxHeight,
        child: Container(
          child: widget.child,
        ),
      ),
    );
  }
}
