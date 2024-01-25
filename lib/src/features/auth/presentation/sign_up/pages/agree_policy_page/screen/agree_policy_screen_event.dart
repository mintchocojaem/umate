part of 'agree_policy_screen.dart';

mixin class AgreePolicyScreenEvent {
  void initScrollController(
    WidgetRef ref, {
    required ScrollController scrollController,
  }) {
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        ref.read(_maxScrollExtentProvider.notifier).update((state) => true);
      } else {
        ref.read(_maxScrollExtentProvider.notifier).update((state) => false);
      }
    });
  }

  Future<void> agreePolicy(
    WidgetRef ref, {
    required ScrollController scrollController,
    required bool maxScrollExtent,
  }) async {
    if (maxScrollExtent) {
      ref.read(agreePolicyProvider.notifier).update((state) => true);
      ref.read(routerProvider).pop();
    } else {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  String agreeButtonText({required bool maxScrollExtent}) {
    return maxScrollExtent ? '모두 동의하기' : '아래로 스크롤하기';
  }
}
