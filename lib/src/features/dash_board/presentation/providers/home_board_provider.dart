import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/home_board.dart';
import '../../domain/use_caces/get_home_board.dart';

final homeBoardProvider =
    AsyncNotifierProvider.autoDispose<HomeBoardNotifier, HomeBoard>(
  () => HomeBoardNotifier(),
);

class HomeBoardNotifier extends AutoDisposeAsyncNotifier<HomeBoard> {
  CancelToken? _cancelToken;

  @override
  FutureOr<HomeBoard> build() {
    // TODO: implement build
    return _fetch();
  }

  Future<void> fetch() async {
    state = await AsyncValue.guard(() => _fetch());
  }

  Future<HomeBoard> _fetch() async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    final result = await ref.read(
      getHomeBoardProvider(
        GetHomeBoardParams(
          cancelToken: _cancelToken,
        ),
      ),
    );

    return result;
  }
}
