import 'package:flutter/material.dart';

import '../presentation.dart';

class AgreeTermsContainer extends StatelessWidget {
  final List<AgreeTermsContent> agreeTermsContents;

  const AgreeTermsContainer({super.key, required this.agreeTermsContents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final agreeTermsContent in agreeTermsContents)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: agreeTermsContent,
          ),
      ],
    );
  }
}