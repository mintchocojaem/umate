import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/app_exception.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../design_system/orb/orb.dart';
import '../../login/providers/login_token_provider.dart';
import '../providers/user_info_provider.dart';

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
      userInfoNotifierProvider,
      (_, next) {
        if (!next.isLoading && next.hasError) {
          final error = next.error;
          if (error is! AppException) return;
          context.showErrorSnackBar(
            error: error,
          );
        }
      },
    );

    final userInfo = ref.watch(userInfoNotifierProvider);

    return OrbScaffold(
      appBar: OrbAppBar(
        backgroundColor: context.palette.primary,
        title: '프로필',
        titleColor: context.palette.onPrimary,
      ),
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: context.palette.primary,
            padding: const EdgeInsets.all(16),
            child: userInfo.when(
              data: (data) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.palette.secondary,
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
                            data.nickname,
                            type: OrbTextType.titleSmall,
                            color: context.palette.onSecondary,
                            fontWeight: OrbFontWeight.medium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          OrbText(
                            "${data.username} ${data.studentId}",
                            color: context.palette.onSecondary,
                          ),
                          OrbText(
                            "${data.department}  ${data.major}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            color: context.palette.onSecondary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => const OrbShimmerContent(),
              error: (error, _) => const OrbShimmerContent(),
            ),
          ),
          /*
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: OrbText(
              'With 단국',
              type: OrbTextType.bodyMedium,
              fontWeight: OrbFontWeight.medium,
              color: context.palette.surfaceDim,
            ),
          ),
          ListTile(
            title: const OrbText(
              '내가 쓴 글',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {},
          ),
          ListTile(
            title: const OrbText(
              '내가 참여한 글',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {
              ref.read(routerServiceProvider).pushNamed(
                    AppRoute.userEatingAloneAppliedBoard.name,
                  );
            },
          ),
          Container(
            height: 16,
            color: context.palette.surfaceBright,
          ),

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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: OrbText(
              '앱 설정',
              type: OrbTextType.bodyMedium,
              fontWeight: OrbFontWeight.medium,
              color: context.palette.surfaceDim,
            ),
          ),
          ListTile(
            splashColor: Colors.transparent,
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
                rightButtonColor: context.palette.error,
                onRightButtonPressed: () async {
                  ref.read(loginTokenNotifierProvider.notifier).logout();
                  return true;
                },
                onLeftButtonPressed: () async {
                  return true;
                },
              ).show(context);
            },
          ),
          ListTile(
            splashColor: Colors.transparent,
            title: const OrbText(
              '회원탈퇴',
              type: OrbTextType.bodyLarge,
            ),
            onTap: () {
              OrbDialog(
                title: '회원탈퇴',
                content: const OrbText(
                  '정말로 회원 탈퇴를 진행할까요? ㅠㅠ',
                  type: OrbTextType.bodyLarge,
                ),
                leftButtonText: '취소',
                rightButtonText: '탈퇴하기',
                rightButtonColor: context.palette.error,
                onRightButtonPressed: () async {
                  await ref
                      .read(userInfoNotifierProvider.notifier)
                      .deleteUser();
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
