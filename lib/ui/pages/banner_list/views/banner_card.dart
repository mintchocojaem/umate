import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final VoidCallback? onTap;
  const BannerCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset(
          'assets/icons/banner_example.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
