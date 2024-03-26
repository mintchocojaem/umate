import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/petition_board_dto.dart';

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
      fromJson: PetitionBoardDTO.fromJson,
    );
  }
}
