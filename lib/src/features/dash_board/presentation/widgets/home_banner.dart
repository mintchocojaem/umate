import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeBanner extends StatefulWidget {
  final List<Widget> banners;

  const HomeBanner({
    super.key,
    required this.banners,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeBannerState();
  }
}

class _HomeBannerState extends State<HomeBanner> {
  final CarouselController _carouselController = CarouselController();

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //carousel
        CarouselSlider(
          carouselController: _carouselController,
          items: widget.banners,
          options: CarouselOptions(
            aspectRatio: 1 / 1,
            clipBehavior: Clip.hardEdge,
            enlargeFactor: 0,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        //indicator
        Positioned.fill(
          bottom: 8,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.banners.map(
                    (e) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == widget.banners.indexOf(e)
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
