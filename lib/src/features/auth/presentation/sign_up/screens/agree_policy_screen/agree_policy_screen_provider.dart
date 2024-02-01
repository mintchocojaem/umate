part of 'agree_policy_screen.dart';

class AgreePolicyScreenState {
  bool maxScrollExtent = false;

  copyWith({
    bool? maxScrollExtent,
  }) {
    return AgreePolicyScreenState()
      ..maxScrollExtent = maxScrollExtent ?? this.maxScrollExtent;
  }
}

final agreePolicyScreenProvider = NotifierProvider.autoDispose<
    AgreePolicyScreenNotifier, AgreePolicyScreenState>(
  () => AgreePolicyScreenNotifier(),
);

class AgreePolicyScreenNotifier
    extends AutoDisposeNotifier<AgreePolicyScreenState> {

  @override
  AgreePolicyScreenState build() {
    // TODO: implement build
    return AgreePolicyScreenState();
  }

  void initScrollController({
    required ScrollController scrollController,
  }) {
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          state.maxScrollExtent == false) {
        state = state.copyWith(maxScrollExtent: true);
      } else if (scrollController.offset <
              scrollController.position.maxScrollExtent &&
          state.maxScrollExtent == true) {
        state = state.copyWith(maxScrollExtent: false);
      }
    });
  }

  Future<void> agreePolicy({
    required ScrollController scrollController,
  }) async {
    if (state.maxScrollExtent) {
      ref.read(agreePolicyProvider.notifier).update((state) => true);
      ref.read(routerProvider).pop();
    } else {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
      state = state.copyWith(maxScrollExtent: true);
    }
  }

  String submitButtonText({required bool maxScrollExtent}) {
    if (maxScrollExtent) {
      return '모두 동의하기';
    }
    return '아래로 스크롤하기';
  }

}

