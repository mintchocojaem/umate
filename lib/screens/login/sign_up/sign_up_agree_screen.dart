import 'package:danvery/modules/orb/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes/router_provider.dart';
import '../../screens.dart';

final _isMaxScrollPositionProvider =
    StateProvider.autoDispose<bool>((ref) => false);

class SignUpAgreeScreen extends ConsumerStatefulWidget {
  const SignUpAgreeScreen({Key? key}) : super(key: key);

  @override
  createState() => _SignUpAgreeScreen();
}

class _SignUpAgreeScreen extends ConsumerState<SignUpAgreeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    final isMaxScrollPositionNotifier =
        ref.read(_isMaxScrollPositionProvider.notifier);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset <
          _scrollController.position.maxScrollExtent) {
        isMaxScrollPositionNotifier.update((state) => false);
      } else {
        isMaxScrollPositionNotifier.update((state) => true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData theme = Theme.of(context);
    final isMaxScrollPosition = ref.watch(_isMaxScrollPositionProvider);
    final isAgreePrivacyPolicy = ref.watch(isAgreePrivacyPolicyProvider);
    final isAgreeThirdParty = ref.watch(isAgreeThirdPartyProvider);
    return OrbScaffold(
      pageHelpText: '단국대학교 학생임을\n인증하기 위한 동의문이에요',
      scrollController: _scrollController,
      submitButton: isMaxScrollPosition
          ? OrbButton(
              onPressed: () async{
                ref
                    .read(isAgreePrivacyPolicyProvider.notifier)
                    .update((state) => true);
                ref
                    .read(isAgreeThirdPartyProvider.notifier)
                    .update((state) => true);
                ref.read(routerProvider).pop();
              },
              buttonText: '모두 동의하기',
            )
          : OrbButton(
              onPressed: () async{
                if (!isMaxScrollPosition) {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.ease,
                  );
                }
              },
              buttonText: '아래로 스크롤하기',
            ),
      body: Column(
        children: [
          const AgreeTermsContainer(
            agreeTermsContents: [
              AgreeTermsContent(
                title: '개인정보 수집 및 이용 동의',
                content:
                    '단국대학교 총학생회 홈페이지는 단국대학교 학생임을 인증하기 위하여 아래와 같이 단국대학교 홈페이지 내 개인정보를 수집, 이용합니다.',
              ),
              AgreeTermsContent(
                title: '거부할 권리와 불이익',
                content:
                    '개인정보 수집 및 이용에 동의하지 않을 수 있으나, 동의를 거부 할 경우 서비스 이용이 불가합니다. 단국대학교 홈페이지 아이디 및 비밀번호는 연동 즉시 폐기됩니다.',
              ),
              AgreeTermsContent(
                title: '정보를 보내는 곳',
                content: '단국대학교 홈페이지',
              ),
              AgreeTermsContent(
                title: '정보를 받는 곳',
                content: '단버리(Danvery)',
              ),
              AgreeTermsContent(
                title: '항목',
                content: '단국대학교 홈페이지 아이디 및 비밀번호',
              ),
              AgreeTermsContent(
                title: '목적',
                content: '단국대학교 학생임을 인증, 학번, 이름, 학과, 재학 여부 인증',
              ),
              AgreeTermsContent(
                title: '종료 시점 / 보유 및 이용기간',
                content: '본인확인 및 재학 여부 인증 목적 달성시까지',
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AgreeTermsContainer(
            agreeTermsContents: [
              AgreeTermsContent(
                title: '개인정보 제 3자 제공 동의',
                content:
                    '단국대학교 총학생회 홈페이지는 개인정보를 개인정보 처리방침에서 고지한 제 3자 제공범위 내에서 제공하며, 정보주체의 사전동의 없이 동 범위를 초과하여 제3자에게 제공하지 않습니다.',
              ),
              AgreeTermsContent(
                title: '거부할 권리와 불이익',
                content:
                    '개인정보 제 3자 제공에 동의하지 않을 수 있으나, 동의를 거부 할 경우 서비스 이용이 불가합니다.',
              ),
              AgreeTermsContent(
                title: '정보를 받는 곳',
                content: '단버리(Danvery)',
              ),
              AgreeTermsContent(
                title: '항목',
                content: '단국대학교 홈페이지 내 학번, 이름, 학과, 성별, 재학여부',
              ),
              AgreeTermsContent(
                title: '목적',
                content: '단국대학교 학생 복지 앱 연동',
              ),
              AgreeTermsContent(
                title: '종료 시점 / 보유 및 이용기간',
                content: '가입일로부터 4년',
              ),
            ],
          ),
          const SizedBox(height: 24),
          OrbListCardTile(
            title: '개인정보 수집 및 이용 동의하기',
            leading: Icon(
              Icons.check_circle_rounded,
              color: isAgreePrivacyPolicy
                  ? Colors.green
                  : theme.colorScheme.onPrimary.withOpacity(0.5),
            ),
            onTap: () {
              ref
                  .read(isAgreePrivacyPolicyProvider.notifier)
                  .update((state) => !state);
              if (ref.read(isAgreeAllProvider)) {
                ref.read(routerProvider).pop();
              }
            },
          ),
          const SizedBox(height: 24),
          OrbListCardTile(
            title: '개인정보 제 3자 제공 동의하기',
            leading: Icon(
              Icons.check_circle_rounded,
              color: isAgreeThirdParty
                  ? Colors.green
                  : theme.colorScheme.onPrimary.withOpacity(0.5),
            ),
            onTap: () {
              ref
                  .read(isAgreeThirdPartyProvider.notifier)
                  .update((state) => !state);
              if (ref.read(isAgreeAllProvider)) {
                ref.read(routerProvider).pop();
              }
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
