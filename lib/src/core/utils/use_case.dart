import 'dart:async';

abstract class UseCase<T, P> {
  Future<T> call({required P params});
}

class NoParams {
  const NoParams();
}
