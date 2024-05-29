import 'package:flutter/material.dart';

enum OrbFontWeight {
  light(FontWeight.w400),
  regular(FontWeight.w500),
  medium(FontWeight.w600),
  bold(FontWeight.w900);

  final FontWeight weight;

  const OrbFontWeight(this.weight);
}

class OrbTextTheme {
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  const OrbTextTheme({
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
  });

}

final class OrbDefaultTextTheme implements OrbTextTheme {
  OrbDefaultTextTheme();

  @override
  final titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: OrbFontWeight.medium.weight,
    fontFamily: 'SpoqaHanSansNeo',
  );

  @override
  final titleMedium = TextStyle(
    fontSize: 20,
    fontWeight: OrbFontWeight.medium.weight,
    fontFamily: 'SpoqaHanSansNeo',
  );

  @override
  final titleSmall = TextStyle(
    fontSize: 18,
    fontWeight: OrbFontWeight.medium.weight,
    fontFamily: 'SpoqaHanSansNeo',
  );

  @override
  final bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: OrbFontWeight.regular.weight,
    fontFamily: 'SpoqaHanSansNeo',
  );

  @override
  final bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: OrbFontWeight.regular.weight,
    fontFamily: 'SpoqaHanSansNeo',
  );

  @override
  final bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: OrbFontWeight.light.weight,
    fontFamily: 'SpoqaHanSansNeo',
  );

  TextTheme toTextTheme() {
    // TODO: implement toTextTheme
    return TextTheme(
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    );
  }

}

final class OrbDefaultLightTextTheme extends OrbDefaultTextTheme {
  OrbDefaultLightTextTheme();

  @override
  // TODO: implement titleLarge
  get titleLarge =>
      super.titleLarge.copyWith(color: Colors.black);

  @override
  get titleMedium =>
      super.titleMedium.copyWith(color: Colors.black);

  @override
  get titleSmall =>
      super.titleSmall.copyWith(color: Colors.black);

  @override
  get bodyLarge =>
      super.bodyLarge.copyWith(color: Colors.grey[900]);

  @override
  get bodyMedium =>
      super.bodyMedium.copyWith(color: Colors.grey[800]);

  @override
  get bodySmall => super.bodySmall.copyWith(color: Colors.grey[700]);
}
