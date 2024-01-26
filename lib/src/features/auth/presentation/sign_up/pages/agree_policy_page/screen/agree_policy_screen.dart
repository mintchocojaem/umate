import 'package:danvery/src/core/core.dart';
import 'package:danvery/src/features/auth/presentation/presentation.dart';
import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'agree_policy_screen_event.dart';

part 'agree_policy_screen_state.dart';

class AgreePolicyScreen extends ConsumerWidget
    with AgreePolicyScreenState, AgreePolicyScreenEvent {
  const AgreePolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final ScrollController scrollController = ScrollController();
    final themeData = Theme.of(context);

    initScrollController(ref, scrollController: scrollController);

    OrbButton orbButton(WidgetRef ref){
      print(2);
      return OrbButton(
        buttonText: agreeButtonText(maxScrollExtent: maxScrollExtent(ref)),
        onPressed: () {
          agreePolicy(
            ref,
            scrollController: scrollController,
            maxScrollExtent: maxScrollExtent(ref),
          );
        },
      );
    }

    print(1);

    return OrbScaffold(
      scrollController: scrollController,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '단국대학교 학생임을\n인증하기 위한 동의문이에요',
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          const OrbBoardContainer(
            child: AgreeTermsContainer(
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
          ),
          const SizedBox(height: 16),
          const OrbBoardContainer(
            child: AgreeTermsContainer(
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
          ),
        ],
      ),
      submitButton: orbButton(ref),
    );
  }
}