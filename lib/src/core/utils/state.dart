import 'package:flutter/foundation.dart';

import 'app_exception.dart';

@immutable
final class AsyncState<T> {
  final T? data;
  final bool hasData;
  final bool isLoading;
  final bool hasError;
  final String? message;
  final StackTrace? stackTrace;

  const AsyncState({
    this.data,
    this.hasData = false,
    this.isLoading = false,
    this.hasError = false,
    this.message,
    this.stackTrace,
  });

  factory AsyncState.initial() {
    return const AsyncState();
  }

  factory AsyncState.loading() {
    return const AsyncState(isLoading: true);
  }

  factory AsyncState.data(T data) {
    return AsyncState(
      data: data,
      hasData: true,
    );
  }

  factory AsyncState.error(String message, StackTrace stackTrace) {
    return AsyncState(
      hasError: true,
      message: message,
      stackTrace: stackTrace,
    );
  }

  static Future<AsyncState<T>> guard<T>(Future<T> Function() future) async {
    try {
      return AsyncState.data(await future());
    } on AppException catch (e) {
      if (kDebugMode) {
        print(
            'AsyncState > (Error) : Error = ${e.message}, StackTrace = ${e.stackTrace}');
      }
      return AsyncState.error(e.message, e.stackTrace);
    }
  }

  AsyncState<T> copyWith({
    T? data,
    bool? hasData,
    bool? isLoading,
    bool? hasError,
    String? message,
    StackTrace? stackTrace,
  }) {
    return AsyncState(
      data: data ?? this.data,
      hasData: hasData ?? this.hasData,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'AsyncState(data: $data, hasData: $hasData, isLoading: $isLoading, hasError: $hasError, message: $message, stackTrace: $stackTrace)';
  }

  R when<R>({
    required R Function(T data) hasData,
    required R Function() isLoading,
    required R Function() hasError,
  }) {
    if (this.hasData) {
      return hasData(data as T);
    } else if (this.isLoading) {
      return isLoading();
    } else {
      return hasError();
    }
  }
}
