part of 'home_screen.dart';

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
        aspectRatio: 1 / 1,
        clipBehavior: Clip.hardEdge,
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
}
