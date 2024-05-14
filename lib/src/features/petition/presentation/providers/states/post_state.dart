
import '../../../domain/models/post.dart';

class PostState {
  const PostState();

}

class PostInitialState extends PostState {
  const PostInitialState();
}

class PostLoadingState extends PostState {
  const PostLoadingState();
}

class PostSuccessState<T extends Post> extends PostState {
  final T post;
  final bool hasError;
  final String message;

  const PostSuccessState({
    required this.post,
    this.hasError = false,
    this.message = '',
  });
}

class PostFailureState extends PostState {
  final String message;
  final bool isCanceled;

  const PostFailureState({
    required this.message,
    required this.isCanceled,
  });
}