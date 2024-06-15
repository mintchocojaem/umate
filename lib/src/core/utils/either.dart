sealed class Either<S, F> {
  const Either();

  bool get isFailure => this is Failure<S, F>;

  bool get isSuccess => this is Success<S, F>;

  F get failure => (this as Failure<S, F>).value;

  S get success => (this as Success<S, F>).value;

  T fold<T>(T Function(S s) onSuccess, T Function(F f) onFailure) {
    if (this is Success<S, F>) {
      return onSuccess((this as Success<S, F>).value);
    } else {
      return onFailure((this as Failure<S, F>).value);
    }
  }
}

class Success<S, F> extends Either<S, F> {
  final S value;

  const Success(this.value);
}

class Failure<S, F> extends Either<S, F> {
  final F value;

  const Failure(this.value);
}
