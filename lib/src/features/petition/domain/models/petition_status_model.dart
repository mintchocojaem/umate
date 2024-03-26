import 'package:flutter/foundation.dart';

import '../../../../core/utils/app_exception.dart';

@immutable
sealed class PetitionStatusModel {
  final String displayName;
  final String value;

  const PetitionStatusModel({
    required this.displayName,
    required this.value,
  });

  factory PetitionStatusModel.fromJson(String json) {
    switch (json) {
      case 'ACTIVE':
        return const PetitionActive();
      case 'WAITING':
        return const PetitionWaiting();
      case 'ANSWERED':
        return const PetitionAnswered();
      case 'EXPIRED':
        return const PetitionExpired();
      default:
        throw AppError(
          message: 'Unknown petition status: $json',
          stackTrace: StackTrace.current,
        );
    }
  }

  @override
  String toString() => displayName;
}

class PetitionActive extends PetitionStatusModel {
  const PetitionActive({
    super.displayName = '진행 중',
    super.value = 'ACTIVE',
  });
}

class PetitionWaiting extends PetitionStatusModel {
  const PetitionWaiting({
    super.displayName = '대기 중',
    super.value = 'WAITING',
  });
}

class PetitionAnswered extends PetitionStatusModel {
  const PetitionAnswered({
    super.displayName = '답변 완료',
    super.value = 'ANSWERED',
  });
}

class PetitionExpired extends PetitionStatusModel {
  const PetitionExpired({
    super.displayName = '기간 만료',
    super.value = 'EXPIRED',
  });
}
