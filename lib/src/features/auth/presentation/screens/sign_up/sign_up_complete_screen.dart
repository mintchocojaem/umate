import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/router/route_error_screen.dart';
import '../../../../../core/services/router/router_service.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../../../auth_dependency_injections.dart';
import '../../providers/states/sign_up_verify_student_state.dart';

@RoutePage()
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
    final signUpVerifyStudentState = ref.watch(signUpVerifyStudentProvider);

    if(signUpVerifyStudentState is! SignUpVerifyStudentSuccess){
      return const RouteErrorScreen();
    }

    final ThemeData themeData = Theme.of(context);

    final submitButton = OrbButton(
      onPressed: () {
        ref.read(routerServiceProvider).replace(const LoginRoute());
      },
      buttonText: '로그인하러 가기',
    );

    return OrbScaffold(
      scrollBody: false,
      body: Stack(
        children: [
          Text(
            '${signUpVerifyStudentState.signUpInfo.student.studentName}님의\n회원가입을 진심으로 축하드려요',
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/celebration.png',
              scale: 3,
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
                              internalRadius * cos(step + halfDegreesPerStep),
                          halfWidth +
                              internalRadius * sin(step + halfDegreesPerStep));
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
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton.copyWith(
        buttonRadius: OrbButtonRadius.none,
      ),
    );
  }
}
