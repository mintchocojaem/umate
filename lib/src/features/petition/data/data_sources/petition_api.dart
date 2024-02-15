import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

final petitionApiProvider = Provider.autoDispose<PetitionApi>((ref) {
  return PetitionApi(dioClient: ref.watch(dioClientProvider));
});

class PetitionApi {
  final DioClient dioClient;

  PetitionApi({required this.dioClient});

  Future<PetitionBoardModel> getPetitionBoard({
    String? keyword,
    required int page,
    int? bodySize,
    required int size,
    required String status,
  }) async {
    final result = await dioClient.request(
      path: '/post/petition',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
        'bodySize': bodySize,
        'status': status,
        'sort': 'createdAt,desc',
      },
    );
    return PetitionBoardModel.fromJson(result.data);
  }

}
