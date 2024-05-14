import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {

  @override
  void didAddProvider(
      ProviderBase<Object?> provider,
      Object? value,
      ProviderContainer container,
      ) {
    if (kDebugMode) {
      print('Provider > ${provider.runtimeType} was initialized with $value');
    }
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider,
      ProviderContainer container,
      ) {
    if (kDebugMode) {
      print('Provider > ${provider.runtimeType} was disposed');
    }
  }

  @override
  void didUpdateProvider(
      ProviderBase<Object?> provider,
      Object? previousValue,
      Object? newValue,
      ProviderContainer container,
      ) {
    if (kDebugMode) {
      print('Provider > ${provider.runtimeType} updated from $previousValue to $newValue');
    }
  }

  @override
  void providerDidFail(
      ProviderBase<Object?> provider,
      Object error,
      StackTrace stackTrace,
      ProviderContainer container,
      ) {
    if (kDebugMode) {
      print('Provider > ${provider.runtimeType} threw $error at $stackTrace');
    }
  }
}
