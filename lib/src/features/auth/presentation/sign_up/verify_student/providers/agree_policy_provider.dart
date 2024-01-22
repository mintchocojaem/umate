import 'package:flutter_riverpod/flutter_riverpod.dart';

final agreePolicyProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});