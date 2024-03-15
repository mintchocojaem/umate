import 'dart:async';

import 'package:flutter/foundation.dart';

import 'async_state.dart';

abstract class UseCase<T, P> {

  @nonVirtual
  Future<AsyncState<T>> call(P params) async {
    final result = await AsyncState.guard(() => execute(params));
    if (result.hasError) {
      if (kDebugMode) {
        print(
            'AsyncState > (Error) : Error = ${result.message}, StackTrace = ${result.stackTrace}');
      }
    }
    return result;
  }

  Future<T> execute(P params);
}

class NoParams {
  const NoParams();
}
