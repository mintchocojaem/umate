import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/modules/orb/theme/orb_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<ThemeData>((ref) {
  return OrbTheme(themeMode : ref.watch(themeModeProvider)).currentTheme;
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.system;
});

final notificationProvider = StateProvider<bool>((ref) {
  return true;
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    return OrbScaffold(
      orbAppBar: OrbAppBar(
        trailing: TextButton(
          onPressed: () {},
          child: Text(
            "수정",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ),
      ),
      shrinkWrap: true,
      body: Column(
        children: [
          OrbBoardContainer(
            titleText: "내 정보",
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/app/profile.png',
                  scale: 3,
                ),
                const SizedBox(
                  height: 32,
                ),
                OrbListTile(
                  tileTextStyle: TileTextStyle.large,
                  boldTitle: true,
                  title: "닉네임",
                  content: "Jaem",
                  contentAlign: CrossAxisAlignment.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                OrbListTile(
                  tileTextStyle: TileTextStyle.large,
                  boldTitle: true,
                  title: "이름",
                  content: "이재민",
                  contentAlign: CrossAxisAlignment.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                OrbListTile(
                  tileTextStyle: TileTextStyle.large,
                  boldTitle: true,
                  title: "학번",
                  content: "32193419",
                  contentAlign: CrossAxisAlignment.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                OrbListTile(
                  tileTextStyle: TileTextStyle.large,
                  boldTitle: true,
                  title: "학과",
                  content: "소프트웨어학과",
                  contentAlign: CrossAxisAlignment.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                OrbListTile(
                  tileTextStyle: TileTextStyle.large,
                  boldTitle: true,
                  title: "전화번호",
                  content: "01099087014",
                  contentAlign: CrossAxisAlignment.end,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbBoardContainer(
            titleText: "활동",
            child: Column(
              children: [
                OrbListCardTile(
                  title: "내가 쓴 청원",
                  content: "3개",
                  contentAlign: CrossAxisAlignment.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                OrbListCardTile(
                  contentAlign: CrossAxisAlignment.end,
                  title: "내가 동의한 청원",
                  content: "100개",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbBoardContainer(
            titleText: "설정",
            child: Column(
              children: [
                OrbListTile(
                  title: "알림",
                  trailing: Switch(
                    value: ref.watch(notificationProvider),
                    inactiveThumbColor: themeData.colorScheme.primary,
                    onChanged: (value) {
                      ref.read(notificationProvider.notifier).state = value;
                    },
                  ),
                ),
                OrbListTile(
                  title: "테마",
                  trailing: DropdownButton(
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    value: themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        ref.read(themeModeProvider.notifier).state = value;
                      }
                    },
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text("시스템"),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text("라이트"),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text("다크"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
