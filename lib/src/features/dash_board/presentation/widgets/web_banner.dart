import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../design_system/orb/orb.dart';

class WebBanner extends StatelessWidget {
  final List<String> urls;
  final Function(int index) onTap;
  final Function(int index) onPageChanged;

  WebBanner({
    super.key,
    required this.urls,
    required this.onTap,
    required this.onPageChanged,
  });

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: context.palette.outline,
      child: CarouselSlider(
        carouselController: _carouselController,
        items: urls.map(
          (e) {
            return InkWell(
              onTap: onTap(urls.indexOf(e)),
              child: Image.network(
                e,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: OrbCircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return OrbIcon(
                    Icons.image_not_supported,
                    size: OrbIconSize.large,
                    color: context.palette.error,
                  );
                },
              ),
            );
          },
        ).toList(),
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
            onPageChanged(index);
          },
        ),
      ),
    );
  }
}
