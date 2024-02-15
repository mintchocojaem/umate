part of 'home_screen.dart';

class HomeBanner extends StatelessWidget {

  const HomeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> bannerPath = [
      "assets/images/test.png",
      "assets/images/test.png",
      "assets/images/test.png",
    ];
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
