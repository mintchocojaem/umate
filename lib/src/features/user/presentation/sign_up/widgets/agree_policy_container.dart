import 'package:flutter/material.dart';

import '../../../../../design_system/orb/orb.dart';

class AgreeTerms {
  final String title;
  final String content;

  const AgreeTerms({
    required this.title,
    required this.content,
  });
}

class AgreeTermsContainer extends StatelessWidget {
  final String title;
  final String content;
  final List<AgreeTerms> agreeTermsContents;

  const AgreeTermsContainer({
    super.key,
    required this.title,
    required this.content,
    required this.agreeTermsContents,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrbText(
            title,
            type: OrbTextType.titleSmall,
            fontWeight: OrbFontWeight.medium,
          ),
          const SizedBox(height: 8),
          OrbText(
            content,
            type: OrbTextType.bodyMedium,
          ),
          const SizedBox(height: 16),
          for (AgreeTerms agreeTerms in agreeTermsContents)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: OrbText(
                    agreeTerms.title,
                    type: OrbTextType.bodyLarge,
                    fontWeight: OrbFontWeight.medium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: OrbText(
                    agreeTerms.content,
                    type: OrbTextType.bodySmall,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}