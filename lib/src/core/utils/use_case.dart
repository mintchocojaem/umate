import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class UseCase<T, P extends UseCaseParams> {
  Future<T> call(P params);
}

abstract class UseCaseParams extends Equatable{
  const UseCaseParams();
}

class NoParams extends UseCaseParams{
  const NoParams();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
