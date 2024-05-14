import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../../../../design_system/orb/orb.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imagePaths;
  final Color selectedIndicatorColor;
  final Color unselectedIndicatorColor;

  const ImageSlider({
    super.key,
    required this.imagePaths,
    this.selectedIndicatorColor = Colors.black,
    this.unselectedIndicatorColor = Colors.grey,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageSliderState();
  }
}

class _ImageSliderState extends State<ImageSlider> {
  late final PageController _pageController;

  int _currentImageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      if (_pageController.page!.round() != _currentImageIndex) {
        setState(() {
          _currentImageIndex = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PostImageDetail(
                      imagePaths: widget.imagePaths,
                      index: _currentImageIndex,
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                child: PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: _pageController,
                  itemCount: widget.imagePaths.length,
                  itemBuilder: (context, index) {
                    return IntrinsicHeight(
                      child: Image.network(
                        widget.imagePaths[index],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                              color: Colors.grey,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        widget.imagePaths.length > 1
            ? Positioned.fill(
                bottom: 8,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IntrinsicWidth(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          widget.imagePaths.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == _currentImageIndex
                                  ? widget.selectedIndicatorColor
                                  : widget.unselectedIndicatorColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class PostImageDetail extends StatefulWidget {
  final List<String> imagePaths;
  final int index;

  const PostImageDetail({
    super.key,
    required this.imagePaths,
    required this.index,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostImageDetailState();
  }
}

class _PostImageDetailState extends State<PostImageDetail> {
  late final PageController _pageController;

  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pageController.addListener(() {
      if (_pageController.page!.round() != _currentIndex) {
        setState(() {
          _currentIndex = _pageController.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: OrbAppBar(
        leading: const SizedBox(),
        title: "${_currentIndex + 1} / ${widget.imagePaths.length}",
        centerTitle: true,
        trailing: IconButton(
          icon: const OrbIcon(
            Icons.close,
            size: OrbIconSize.medium,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: InteractiveViewer(
        child: InkWell(
          onLongPress: () {
            showOrbModalBottomSheet(
              context,
              OrbModalBottomSheet(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const OrbIcon(
                        Icons.download,
                        size: OrbIconSize.medium,
                      ),
                      title: const OrbText(
                        '이미지 저장',
                      ),
                      onTap: () {
                        GallerySaver.saveImage(
                          widget.imagePaths[_currentIndex],
                        ).catchError((error) {
                          return false;
                        }).then((value) {
                          Navigator.of(context).pop();
                          if (value != null && value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const OrbSnackBar(
                                message: '이미지가 저장되었습니다.',
                                type: OrbSnackBarType.info,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const OrbSnackBar(
                                message: '이미지 저장에 실패했습니다.',
                                type: OrbSnackBarType.error,
                              ),
                            );
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.imagePaths[index],
              );
            },
          ),
        ),
      ),
    );
  }
}
