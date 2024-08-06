import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../design_system/orb/orb.dart';

class AgreePolicySheet extends OrbModalBottomSheet {
  final Color enabledColor;
  final Color disabledColor;

  final FutureOr<void> Function()? onAgree;
  final FutureOr<void> Function() onTapCollectUserInfo;
  final FutureOr<void> Function() onTapThirdParty;

  const AgreePolicySheet({
    super.key,
    this.onAgree,
    required this.enabledColor,
    required this.disabledColor,
    required this.onTapCollectUserInfo,
    required this.onTapThirdParty,
  });

  @override
  // TODO: implement titleText
  String? get titleText => '학생인증을 위해 동의가 필요해요';

  @override
  // TODO: implement child
  Widget? get child {
    final ValueNotifier<bool> agreeCollectUserInfo = ValueNotifier(false);
    final ValueNotifier<bool> agreeThirdParty = ValueNotifier(false);
    final ValueNotifier<bool> agreeAll = ValueNotifier(false);
    return Column(
      children: [
        OrbTile(
          leading: ValueListenableBuilder(
            valueListenable: agreeAll,
            builder: (context, value, child) {
              return OrbIcon(
                Icons.check_rounded,
                color: agreeAll.value ? enabledColor : disabledColor,
              );
            },
          ),
          title: Row(
            children: [
              const OrbText(
                '동의 전체 선택',
                type: OrbTextType.bodyLarge,
                fontWeight: OrbFontWeight.medium,
              ),
              OrbText(
                '(필수)',
                color: enabledColor,
                type: OrbTextType.bodyLarge,
                fontWeight: OrbFontWeight.medium,
              ),
            ],
          ),
          onTap: () async {
            agreeAll.value = !agreeAll.value;
            agreeCollectUserInfo.value = agreeAll.value;
            agreeThirdParty.value = agreeAll.value;
          },
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            OrbTile(
              leading: ValueListenableBuilder(
                valueListenable: agreeCollectUserInfo,
                builder: (context, value, child) {
                  return OrbIcon(
                    Icons.check_rounded,
                    color: agreeCollectUserInfo.value
                        ? enabledColor
                        : disabledColor,
                  );
                },
              ),
              trailing: IconButton(
                icon: const OrbIcon(Icons.chevron_right_rounded),
                visualDensity: VisualDensity.compact,
                onPressed: onTapCollectUserInfo,
              ),
              title: Row(
                children: [
                  const OrbText(
                    '개인정보 수집 및 이용에 동의',
                  ),
                  OrbText(
                    '(필수)',
                    color: enabledColor,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              backgroundColor: Colors.transparent,
              onTap: () async {
                agreeCollectUserInfo.value = !agreeCollectUserInfo.value;
                if (agreeCollectUserInfo.value && agreeThirdParty.value) {
                  agreeAll.value = true;
                } else {
                  agreeAll.value = false;
                }
              },
            ),
            OrbTile(
              leading: ValueListenableBuilder(
                valueListenable: agreeThirdParty,
                builder: (context, value, child) {
                  return OrbIcon(
                    Icons.check_rounded,
                    color: agreeThirdParty.value ? enabledColor : disabledColor,
                  );
                },
              ),
              trailing: IconButton(
                visualDensity: VisualDensity.compact,
                icon: const OrbIcon(Icons.chevron_right_rounded),
                onPressed: onTapThirdParty,
              ),
              title: Row(
                children: [
                  const OrbText(
                    '개인정보 제3자 제공에 동의',
                  ),
                  OrbText(
                    '(필수)',
                    color: enabledColor,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              backgroundColor: Colors.transparent,
              onTap: () async {
                agreeThirdParty.value = !agreeThirdParty.value;
                if (agreeCollectUserInfo.value && agreeThirdParty.value) {
                  agreeAll.value = true;
                } else {
                  agreeAll.value = false;
                }
              },
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        ValueListenableBuilder(
          valueListenable: agreeAll,
          builder: (context, value, child) {
            return OrbFilledButton(
              disabled: !agreeAll.value,
              onPressed: () async {
                await onAgree?.call();
              },
              text: '다음',
            );
          },
        ),
      ],
    );
  }
}
