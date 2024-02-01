part of 'agree_policy_screen.dart';

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
