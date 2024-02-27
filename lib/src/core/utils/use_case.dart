import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class UseCase<T, P> {
  Future<AsyncValue<T>> call({required P params});
}

class NoParams {
  const NoParams();
}
