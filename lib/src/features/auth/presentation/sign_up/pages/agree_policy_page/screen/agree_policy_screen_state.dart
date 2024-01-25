part of 'agree_policy_screen.dart';

final _maxScrollExtentProvider =
    StateProvider.autoDispose<bool>((ref) => false);

mixin class AgreePolicyScreenState {
  bool maxScrollExtent(WidgetRef ref) {
    return ref.watch(_maxScrollExtentProvider);
  }
}
