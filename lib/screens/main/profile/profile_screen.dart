import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/modules/orb/theme/orb_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/domain.dart';

final themeProvider = StateProvider<ThemeData>((ref) {
  return OrbTheme(themeMode: ref.watch(themeModeProvider)).currentTheme;
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.dark;
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
    final user = ref.watch(userProvider);
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
            child: user.when(
              data: (data) {
                return Column(
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
                      boldTitleText: true,
                      titleText: "닉네임",
                      contentText: data.nickname,
                      contentAlign: CrossAxisAlignment.end,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OrbListTile(
                      tileTextStyle: TileTextStyle.large,
                      boldTitleText: true,
                      titleText: "이름",
                      contentText: data.username,
                      contentAlign: CrossAxisAlignment.end,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OrbListTile(
                      tileTextStyle: TileTextStyle.large,
                      boldTitleText: true,
                      titleText: "학번",
                      contentText: data.studentId,
                      contentAlign: CrossAxisAlignment.end,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OrbListTile(
                      tileTextStyle: TileTextStyle.large,
                      boldTitleText: true,
                      titleText: "학과",
                      contentText: data.major,
                      contentAlign: CrossAxisAlignment.end,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    OrbListTile(
                      tileTextStyle: TileTextStyle.large,
                      boldTitleText: true,
                      titleText: "전화번호",
                      contentText: data.phoneNumber,
                      contentAlign: CrossAxisAlignment.end,
                    ),
                  ],
                );
              },
              loading: () => const OrbShimmerContent(),
              error: (error, stackTrace) => const OrbShimmerContent(),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          OrbBoardContainer(
            titleText: "활동",
            child: user.when(
              data: (data) {
                return const Column(
                  children: [
                    OrbListCardTile(
                      titleText: "내가 쓴 청원",
                      contentText: "100",
                      contentAlign: CrossAxisAlignment.end,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    OrbListCardTile(
                      contentAlign: CrossAxisAlignment.end,
                      titleText: "내가 동의한 청원",
                      contentText: "100개",
                    ),
                  ],
                );
              },
              error: (error, trace) => const OrbShimmerContent(),
              loading: () => const OrbShimmerContent(),
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
                  titleText: "알림",
                  trailing: Switch(
                    value: ref.watch(notificationProvider),
                    inactiveThumbColor: themeData.colorScheme.primary,
                    onChanged: (value) {
                      ref.read(notificationProvider.notifier).state = value;
                    },
                  ),
                ),
                OrbListTile(
                  titleText: "테마",
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
