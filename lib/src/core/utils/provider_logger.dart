import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  int _counter = 0;

  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value,
      ProviderContainer container) {
    // TODO: implement didAddProvider
    super.didAddProvider(provider, value, container);
    if (kDebugMode) {
      _counter++;
      print("ProviderLogger[$_counter] > ${provider.runtimeType} created");
    }
  }

  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, container);
    if (kDebugMode) {
      _counter++;
      print("ProviderLogger[$_counter] > ${provider.runtimeType} disposed");
    }
  }
}
