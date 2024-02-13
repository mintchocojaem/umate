
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  final List<String> bannerPath;

  const HomeBanner({
    super.key,
    required this.bannerPath,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: bannerPath.map(
        (e) {
          return Builder(
            builder: (context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  e,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        aspectRatio: 12 / 9,
        clipBehavior: Clip.hardEdge,
        viewportFraction: 0.75,
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
}
