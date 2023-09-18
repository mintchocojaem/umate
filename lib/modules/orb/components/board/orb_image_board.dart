import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../components.dart';

class OrbImageBoard extends OrbBoardContainer {
  final List<Widget?> images;

  const OrbImageBoard({
    super.key,
    required super.titleText,
    required this.images,
  });

  @override
  // TODO: implement trailing
  Widget? get trailing => const Icon(Icons.chevron_right);

  @override
  // TODO: implement child
  Widget get child => CarouselSlider(
    items: [...images].map(
      (e) {
        return Builder(
          builder: (context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: e,
            );
          },
        );
      },
    ).toList(),
    options: CarouselOptions(
      clipBehavior: Clip.hardEdge,
      aspectRatio: 1.2,
      viewportFraction: 0.8,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 10),
      autoPlayAnimationDuration: const Duration(seconds: 2),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    ),
  );

}
