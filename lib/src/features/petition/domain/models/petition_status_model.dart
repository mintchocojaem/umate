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
        return _PetitionActive();
      case 'WAITING':
        return _PetitionWaiting();
      case 'ANSWERED':
        return _PetitionAnswered();
      case 'EXPIRED':
        return _PetitionExpired();
      default:
        throw Exception('Unknown petition status: $json');
    }
  }

  @override
  String toString() => displayName;
}

class _PetitionActive extends PetitionStatusModel {
  _PetitionActive() : super(displayName: '진행 중', value: 'ACTIVE');
}

class _PetitionWaiting extends PetitionStatusModel {
  _PetitionWaiting() : super(displayName: '대기 중', value: 'WAITING');
}

class _PetitionAnswered extends PetitionStatusModel {
  _PetitionAnswered() : super(displayName: '답변 완료', value: 'ANSWERED');
}

class _PetitionExpired extends PetitionStatusModel {
  _PetitionExpired() : super(displayName: '기간 만료', value: 'EXPIRED');
}
