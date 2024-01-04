import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/route_path.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/auth/user/user_provider.dart';

class ProfileEditScreen extends ConsumerStatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  createState() => _ProfileEditScreen();
}

// userprovider가 먼저 초기화 되어있어야함 -> 이거 해결할 방법찾아야함
// userprovider가 초기화 되어있는지 확인하고 안되어있으면 초기화 시키는 방법
// 초기화 안된채로 접근시 오류 다이얼로그 -> Orbscaffold에서 제공하면 될듯
class _ProfileEditScreen extends ConsumerState<ProfileEditScreen> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nicknameController;
  late final TextEditingController _phoneNumberController;

  @override
  void initState() {
    // TODO: implement initState
    _formKey = GlobalKey<FormState>();
    _nicknameController = TextEditingController();
    _nicknameController.text = ref.read(userProvider).value?.nickname ?? "";
    _phoneNumberController = TextEditingController();
    _phoneNumberController.text =
        ref.read(userProvider).value?.phoneNumber ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nicknameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      orbAppBar: const OrbAppBar(
        title: "프로필 수정",
        centerTitle: true,
      ),
      shrinkWrap: true,
      body: ref.watch(userProvider).when(
            data: (data) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    OrbTextFormField(
                      controller: _nicknameController,
                      labelText: "닉네임",
                      hintText: "닉네임을 입력해주세요.",
                      onChanged: (value) {
                        ref
                            .read(profileEditNicknameProvider.notifier)
                            .update((state) => value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "닉네임을 입력해주세요.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    OrbTextFormField(
                      controller: _phoneNumberController,
                      labelText: "전화번호",
                      hintText: "전화번호를 입력해주세요.",
                      onChanged: (value) {
                        ref
                            .read(profileEditPhoneNumberProvider.notifier)
                            .update((state) => value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "전화번호를 입력해주세요.";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox(),
            error: (error, stackTrace) => const SizedBox(),
          ),
      submitButton: OrbButton(
          buttonText: "수정완료",
          disabled: !ref.watch(profileEditableProvider),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              bool validNickname = false;

              if (_nicknameController.text !=
                  ref.read(userProvider).value?.nickname) {
                await ref
                    .read(userProvider.notifier)
                    .validNickname(_nicknameController.text)
                    .then((value) => validNickname = value);
              }

              if (_phoneNumberController.text !=
                  ref.read(userProvider).value?.phoneNumber) {
                if (!mounted) return;
                await OrbDialog(
                  title: "전화번호 변경",
                  content: Text(
                    "전화번호를 변경하려면 인증이 필요해요.",
                    style: themeData.textTheme.bodyMedium,
                  ),
                  leftButtonText: "취소",
                  rightButtonText: "인증하기",
                  onLeftButtonPressed: () {},
                  onRightButtonPressed: () async {
                    ref
                        .read(routerProvider)
                        .push(RouteInfo.profileEditVerifySMS.fullPath,
                            extra: _phoneNumberController.text)
                        .whenComplete(() async {
                      if (validNickname) {
                        await ref
                            .read(userProvider.notifier)
                            .changeNickname(_nicknameController.text);
                      }
                    });
                  },
                ).show(context);
              } else {
                if (validNickname) {
                  await ref
                      .read(userProvider.notifier)
                      .changeNickname(_nicknameController.text);
                }
              }
            }
          }),
    );
  }
}
