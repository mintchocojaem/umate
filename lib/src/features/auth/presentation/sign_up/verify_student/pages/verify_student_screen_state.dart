import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../presentation.dart';


mixin VerifyStudentScreenState {
  //state of screen
  bool isAgreePolicy(WidgetRef ref) => ref.watch(agreePolicyProvider);
}