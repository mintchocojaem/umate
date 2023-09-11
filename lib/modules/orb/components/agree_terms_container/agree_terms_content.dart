import 'package:flutter/material.dart';

class AgreeTermsContent extends StatelessWidget{

  final String title;
  final String content;

  const AgreeTermsContent({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
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
