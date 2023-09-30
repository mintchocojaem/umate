import 'package:flutter/material.dart';

class PetitionComment extends StatelessWidget {
  final String body;

  const PetitionComment({super.key,required this.body});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "청원답변",
            style: themeData.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            body,
            style: themeData.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
