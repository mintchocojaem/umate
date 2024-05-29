import 'dart:async';

import 'package:flutter/foundation.dart';

import 'app_exception.dart';
import 'either.dart';

abstract class UseCase<T, P extends UseCaseParams> {
  @nonVirtual
  Future<Either<T, AppException>> call(P params) async {
    try {
      return Left(await execute(params));
    } on AppException catch (error) {
      /*
      if (kDebugMode) {
        print('UseCase > message: ${error.message}, stackTrace: ${error.stackTrace}');
      }
       */
      return Right(
        error,
      );
    }
  }

  Future<T> execute(P params);
}

abstract class UseCaseParams {
  const UseCaseParams();
}

class NoParams extends UseCaseParams {
  const NoParams();
}
