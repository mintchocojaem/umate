import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/route_error_screen.dart';
import '../../../../../core/services/router/router_service.dart';
import '../../../../../design_system/orb/orb.dart';
import '../../../user_dependency_injections.dart';
import '../../providers/states/sign_up_state.dart';

class SignUpCompleteScreen extends ConsumerStatefulWidget {
  const SignUpCompleteScreen({
    super.key,
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
    final signUpState = ref.watch(signUpProvider);

    if (signUpState is! SignUpSuccessState) {
      return const RouteErrorScreen();
    }

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return OrbScaffold(
      appBar: const OrbAppBar(),
      title: '회원가입이\n완료되었어요',
      extendBodyBehindTitle: true,
      body: Column(
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
                              signUpState.studentName,
                              color: currentPalette.primary,
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                          final degreesPerStep = degToRad(360 / numberOfPoints);
                          final halfDegreesPerStep = degreesPerStep / 2;
                          final fullAngle = degToRad(360);
                          path.moveTo(size.width, halfWidth);

                          for (double step = 0;
                              step < fullAngle;
                              step += degreesPerStep) {
                            path.lineTo(halfWidth + externalRadius * cos(step),
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
              await ref.read(loginProvider.notifier).login(
                    studentId: signUpState.studentId,
                    password: signUpState.password,
                  );

              ref.read(routerServiceProvider).pushReplacementNamed(
                    AppRoute.home.name,
                  );
            },
          ),
        ],
      ),
    );
  }
}
