import 'dart:io';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/orb/components/components.dart';
import '../sign_up_provider.dart';

class SignUpCompleteScreen extends ConsumerStatefulWidget {
  const SignUpCompleteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpCompleteScreen();
}

class _SignUpCompleteScreen extends ConsumerState<SignUpCompleteScreen> {
  late ConfettiController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
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
    final signup = ref.read(signUpProvider);
    return OrbScaffold(
      pageHelpText: '${signup.value!.student.studentName}님의\n회원가입을 진심으로 축하드려요',
      body: Expanded(
        child: Stack(
          children: [
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
                    _controller.play();
                  }
                  return ConfettiWidget(
                    confettiController: _controller,
                    blastDirectionality: BlastDirectionality.explosive,
                    shouldLoop: false,
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ],
                    createParticlePath: drawStar,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () {
          ref.read(routerProvider).pop();
        },
        child: const Text('로그인하러 가기'),
      ),
    );
  }
}
