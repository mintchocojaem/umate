import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confetti/confetti.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../design_system/orb/orb.dart';
import '../providers/login_token_provider.dart';
import '../providers/sign_up_info_provider.dart';

class SignUpCompleteScreen extends ConsumerStatefulWidget {
  final String userPassword;

  const SignUpCompleteScreen({
    super.key,
    required this.userPassword,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SignUpCompleteScreenState();
  }
}

class _SignUpCompleteScreenState extends ConsumerState<SignUpCompleteScreen> {
  final ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 3));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    confettiController.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    final path = Path();

    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final signUpInfo = ref.watch(signUpInfoProvider);

    return OrbScaffold(
      appBar: OrbAppBar(
        onAutoImplyLeadingPressed: () {
          ref.read(routerServiceProvider).pop();
        },
      ),
      title: '회원가입이\n완료되었어요',
      extendBodyBehindTitle: true,
      body: signUpInfo.when(
        data: (signUpInfo) {
          if (signUpInfo == null) {
            return const OrbShimmerContent();
          }

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/celebration.png',
                            scale: 3,
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                constraints: const BoxConstraints(
                                  maxWidth: 200,
                                ),
                                child: OrbText(
                                  signUpInfo.studentInfo.studentName,
                                  color: context.palette.primary,
                                  type: OrbTextType.titleMedium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const OrbText(
                                '님',
                                type: OrbTextType.titleMedium,
                              ),
                            ],
                          ),
                          const OrbText(
                            '만나서 반가워요!',
                            type: OrbTextType.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: FutureBuilder(
                        future: Future.delayed(
                          const Duration(milliseconds: 500),
                        ),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            confettiController.play();
                          }
                          return ConfettiWidget(
                            confettiController: confettiController,
                            blastDirectionality: BlastDirectionality.explosive,
                            shouldLoop: false,
                            colors: const [
                              Colors.green,
                              Colors.blue,
                              Colors.pink,
                              Colors.orange,
                              Colors.purple
                            ],
                            createParticlePath: (Size size) {
                              final path = Path();

                              double degToRad(double deg) => deg * (pi / 180.0);

                              const numberOfPoints = 5;
                              final halfWidth = size.width / 2;
                              final externalRadius = halfWidth;
                              final internalRadius = halfWidth / 2.5;
                              final degreesPerStep =
                                  degToRad(360 / numberOfPoints);
                              final halfDegreesPerStep = degreesPerStep / 2;
                              final fullAngle = degToRad(360);
                              path.moveTo(size.width, halfWidth);

                              for (double step = 0;
                                  step < fullAngle;
                                  step += degreesPerStep) {
                                path.lineTo(
                                    halfWidth + externalRadius * cos(step),
                                    halfWidth + externalRadius * sin(step));
                                path.lineTo(
                                    halfWidth +
                                        internalRadius *
                                            cos(step + halfDegreesPerStep),
                                    halfWidth +
                                        internalRadius *
                                            sin(step + halfDegreesPerStep));
                              }
                              path.close();
                              return path;
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              OrbFilledButton(
                text: '시작하기',
                onPressed: () async {
                  await ref.read(loginTokenProvider.notifier).login(
                        studentId: signUpInfo.studentInfo.studentId,
                        password: widget.userPassword,
                      );
                },
              ),
            ],
          );
        },
        loading: () => const OrbShimmerContent(),
        error: (error, _) => const OrbShimmerContent(),
      ),
    );
  }
}
