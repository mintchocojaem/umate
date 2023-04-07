import 'package:flutter/material.dart';

class TimeoutIndicator extends StatelessWidget {
  const TimeoutIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

}
