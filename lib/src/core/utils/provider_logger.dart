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
      print("ProviderLogger[$_counter] > (Created) ${provider.runtimeType}");
    }
  }

  @override
  void providerDidFail(ProviderBase<Object?> provider, Object error, StackTrace stackTrace, ProviderContainer container) {
    // TODO: implement providerDidFail
    super.providerDidFail(provider, error, stackTrace, container);
    if (kDebugMode) {
      _counter++;
      print("ProviderLogger[$_counter] > (Failed) ${provider.runtimeType}");
    }
  }


  @override
  void didDisposeProvider(
      ProviderBase<Object?> provider, ProviderContainer container) {
    // TODO: implement didDisposeProvider
    super.didDisposeProvider(provider, container);
    if (kDebugMode) {
      _counter++;
      print("ProviderLogger[$_counter] > (Disposed) ${provider.runtimeType}");
    }
  }
}
