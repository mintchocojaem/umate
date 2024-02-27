import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncResult{

  static Future<AsyncValue<T>> fetch<T>(Future<T> Function() future) async {
    try {
      final result = await future();
      return AsyncValue.data(result);
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print('AsyncResult > Error: $error, StackTrace: $stackTrace');
      }
      return AsyncValue.error(error, stackTrace);
    }
  }
}
