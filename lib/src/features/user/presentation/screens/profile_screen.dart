import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../../user_dependency_injections.dart';
import '../providers/states/user_info_state.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userInfoProvider,
      (prev, next) {
        if (next is UserInfoFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        } else if (next is UserInfoDeletedState) {
          ref.read(routerServiceProvider).goNamed(
                AppRoute.login.name,
                closeKeyboard: true,
              );
        }
      },
    );

    final userInfoState = ref.watch(userInfoProvider);

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      appBar: OrbAppBar(
        backgroundColor: currentPalette.primary,
        title: '프로필',
        titleColor: currentPalette.onPrimary,
      ),
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          Container(
            color: currentPalette.primary,
            padding: const EdgeInsets.all(16),
            child: switch (userInfoState) {
              UserInfoSuccessState success => Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: currentPalette.secondary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          'assets/icons/profile.png',
                          width: 64,
                          height: 64,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            OrbText(
                              success.userInfo.nickname,
                              type: OrbTextType.titleSmall,
                              color: currentPalette.onSecondary,
                              fontWeight: OrbFontWeight.medium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            OrbText(
                              "${success.userInfo.username} ${success.userInfo.studentId}",
                              color: currentPalette.onSecondary,
                            ),
                            OrbText(
                              "${success.userInfo.department}  ${success.userInfo.major}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              color: currentPalette.onSecondary,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              _ => const OrbShimmerContent(),
            },
          ),
          /*
          ListTile(
            title: const OrbText(
              '내 정보 수정',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const OrbText(
              '내가 쓴 글',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {},
          ),
          Container(
            height: 16,
            color: currentPalette.surfaceBright,
          ),
          ListTile(
            title: const OrbText(
              '알림 설정',
              type: OrbTextType.bodyLarge,
            ),
            trailing: OrbSwitch(
              value: false,
              onChanged: (value) {},
            ),
            onTap: () {},
          ),

          ListTile(
            title: const OrbText(
              '테마',
              type: OrbTextType.bodyLarge,
            ),
            trailing: DropdownButton(
              value: 'system',
              items: [
                DropdownMenuItem(
                  child: const OrbText('시스템'),
                  value: 'system',
                ),
                DropdownMenuItem(
                  child: const OrbText('라이트'),
                  value: 'light',
                ),
                DropdownMenuItem(
                  child: const OrbText('다크'),
                  value: 'dark',
                ),
              ],
              onChanged: (value) {},
            ),
            onTap: () {},
          ),
          Container(
            height: 16,
            color: currentPalette.surfaceBright,
          ),
           */
          ListTile(
            title: const OrbText(
              '로그아웃',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {
              OrbDialog(
                title: '로그아웃',
                content: const OrbText(
                  '정말로 로그아웃 하시겠어요?',
                  type: OrbTextType.bodyLarge,
                ),
                leftButtonText: '취소',
                rightButtonText: '로그아웃',
                rightButtonColor: currentPalette.error,
                onRightButtonPressed: () async {
                  ref.read(loginProvider.notifier).logout();
                  ref.read(routerServiceProvider).goNamed(
                        AppRoute.login.name,
                        closeKeyboard: true,
                      );
                  return true;
                },
                onLeftButtonPressed: () async {
                  return true;
                },
              ).show(context);
            },
          ),
          ListTile(
            title: const OrbText(
              '회원탈퇴',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {
              OrbDialog(
                title: '회원탈퇴',
                content: const OrbText(
                  '정말로 탈퇴 하시겠어요?\n\n(탈퇴 후에는 계정 복구가 불가능합니다)',
                  type: OrbTextType.bodyLarge,
                ),
                leftButtonText: '취소',
                rightButtonText: '탈퇴하기',
                rightButtonColor: currentPalette.error,
                onRightButtonPressed: () async {
                  await ref.read(userInfoProvider.notifier).deleteUser();
                  return true;
                },
                onLeftButtonPressed: () async {
                  return true;
                },
              ).show(context);
            },
          ),
        ],
      ),
    );
  }
}
