import 'package:flutter/material.dart';

class AgreeTermsContainer extends StatelessWidget {
  final List<AgreeTermsContent> agreeTermsContents;

  const AgreeTermsContainer({
    super.key,
    required this.agreeTermsContents,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final content in agreeTermsContents)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: AgreeTermsContent(
              title: content.title,
              content: content.content,
            ),
          ),
      ],
    );
  }
}

class AgreeTermsContent extends StatelessWidget {
  final String title;
  final String content;

  const AgreeTermsContent({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
