part of 'home_screen.dart';

class HomeExtraMenu {
  final String title;
  final String content;
  final String imagePath;
  final String url;

  const HomeExtraMenu({
    required this.title,
    required this.content,
    required this.imagePath,
    required this.url,
  });
}

class HomeBottomMenuBar extends StatelessWidget {
  final List<HomeExtraMenu> menuList;

  const HomeBottomMenuBar({
    super.key,
    required this.menuList,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menuList.map(
          (menu) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: OrbCardTile(
                title: Text(
                  menu.title,
                  textAlign: TextAlign.start,
                  style: themeData.textTheme.bodySmall?.copyWith(
                    color: themeData.colorScheme.onSurface.withOpacity(0.8),
                  ),
                ),
                content: Text(
                  menu.content,
                  style: themeData.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subContent: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    menu.imagePath,
                    scale: 3,
                  ),
                ),
                onTap: () async {
                  if (!await launchUrl(Uri.parse(menu.url))) {
                    /*
                    throw const ExceptionDto(
                      code: 'CANNOT_LAUNCH_URL',
                      message: '링크를 열 수 없어요',
                    );
                     */
                  }
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
