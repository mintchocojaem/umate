import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onTap;
  final VoidCallback? onTapDetail;
  final int totalBannerCount;
  final int currentBannerIndex;
  final bool showDetail;

  const BannerCard({
    super.key,
    this.onTap,
    this.onTapDetail,
    required this.imageUrl,
    required this.totalBannerCount,
    required this.currentBannerIndex,
    this.showDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        if(showDetail) Positioned.fill(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 8,
              ),
              child: MaterialButton(
                elevation: 0,
                height: 32,
                minWidth: 48,
                visualDensity: VisualDensity.compact,
                onPressed: onTapDetail,
                color: Palette.darkGrey.withOpacity(0.6),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5),),),
                child: Text(
                    "$currentBannerIndex/$totalBannerCount",
                    style: tinyStyle.copyWith(color: Palette.white)
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
