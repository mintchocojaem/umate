import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../orb.dart';

class OrbShimmerContent extends StatelessWidget {
  final double contentWidth;
  final double contentHeight;
  final double subContentHeight;
  final double subContentPadding;
  final EdgeInsets? padding;

  const OrbShimmerContent({
    super.key,
    this.contentWidth = 96,
    this.contentHeight = 96,
    this.subContentHeight = 8,
    this.subContentPadding = 4,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    return Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: theme.shimmerTheme.baseColor,
        highlightColor: theme.shimmerTheme.highlightColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: contentWidth,
              height: contentHeight,
              decoration: BoxDecoration(
                color: theme.shimmerTheme.highlightColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: subContentHeight,
                    decoration: BoxDecoration(
                      color: theme.shimmerTheme.highlightColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: subContentPadding),
                  ),
                  Container(
                    width: double.infinity,
                    height: subContentHeight,
                    decoration: BoxDecoration(
                      color: theme.shimmerTheme.highlightColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: subContentPadding),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: subContentHeight,
                    decoration: BoxDecoration(
                      color: theme.shimmerTheme.highlightColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
