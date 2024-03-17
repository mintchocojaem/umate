import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/petition_board_dto.dart';

final petitionRemoteDataSourceProvider =
    Provider.autoDispose<PetitionRemoteDataSource>((ref) {
  return PetitionRemoteDataSource(
      networkClientService: ref.read(networkClientServiceProvider));
});

class PetitionRemoteDataSource extends RemoteDataSource {
  PetitionRemoteDataSource({required super.networkClientService});

  Future<PetitionBoardDTO> getPetitionBoard({
    String? keyword,
    String? status,
    int? bodySize,
    int? page,
    int? size,
    String? sort,
  }) async {
    return request(
      path: '/post/petition',
      method: RequestType.get,
      data: {
        'keyword': keyword,
        'status': status,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort,
      },
      fromJson: (json) => PetitionBoardDTO.fromJson(json),
    );
  }
}
