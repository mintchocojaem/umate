import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../widgets/agree_policy_container.dart';

class SignUpAgreePolicyScreen extends ConsumerStatefulWidget {
  const SignUpAgreePolicyScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpAgreePolicyScreenState();
  }
}

class _SignUpAgreePolicyScreenState
    extends ConsumerState<SignUpAgreePolicyScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return OrbScaffold(
      padding: EdgeInsets.zero,
      appBar: OrbAppBar(
        title: '이용약관 동의',
        centerTitle: true,
        onAutoImplyLeadingPressed: () {
          ref.read(routerServiceProvider).pop();
        },
      ),
      disableSafeAreaBottom: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AgreeTermsContainer(
              title: '개인정보 수집 및 이용 동의',
              content:
                  'U Mate는 단국대학교 학생임을 인증하기 위하여 아래와 같이 단국대학교 홈페이지 내 개인정보를 수집, 이용합니다.',
              agreeTermsContents: [
                AgreeTerms(
                  title: '거부할 권리와 불이익',
                  content:
                      '개인정보 수집 및 이용에 동의하지 않을 수 있으나, 동의를 거부 할 경우 서비스 이용이 불가합니다. 단국대학교 홈페이지 아이디 및 비밀번호는 연동 즉시 폐기됩니다.',
                ),
                AgreeTerms(
                  title: '정보를 보내는 곳',
                  content: '단국대학교 홈페이지',
                ),
                AgreeTerms(
                  title: '정보를 받는 곳',
                  content: 'U Mate',
                ),
                AgreeTerms(
                  title: '항목',
                  content: '단국대학교 홈페이지 아이디 및 비밀번호',
                ),
                AgreeTerms(
                  title: '목적',
                  content: '단국대학교 학생임을 인증, 학번, 이름, 학과, 재학 여부 인증',
                ),
                AgreeTerms(
                  title: '종료 시점 / 보유 및 이용기간',
                  content: '본인확인 및 재학 여부 인증 목적 달성시까지',
                ),
              ],
            ),
            Container(
              height: 16,
              color: context.palette.surfaceBright,
            ),
            const AgreeTermsContainer(
              title: '개인정보 제 3자 제공 동의',
              content:
                  'U Mate는 개인정보를 개인정보 처리방침에서 고지한 제 3자 제공범위 내에서 제공하며, 정보주체의 사전동의 없이 동 범위를 초과하여 제3자에게 제공하지 않습니다.',
              agreeTermsContents: [
                AgreeTerms(
                  title: '거부할 권리와 불이익',
                  content:
                      '개인정보 제 3자 제공에 동의하지 않을 수 있으나, 동의를 거부 할 경우 서비스 이용이 불가합니다.',
                ),
                AgreeTerms(
                  title: '정보를 받는 곳',
                  content: 'U Mate',
                ),
                AgreeTerms(
                  title: '항목',
                  content: '단국대학교 홈페이지 내 학번, 이름, 학과, 성별, 재학여부',
                ),
                AgreeTerms(
                  title: '목적',
                  content: '단국대학교 학생 복지 앱 연동',
                ),
                AgreeTerms(
                  title: '종료 시점 / 보유 및 이용기간',
                  content: '가입일로부터 4년',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
