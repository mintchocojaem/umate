import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final boardRepositoryProvider =
    Provider<BoardRepository>((ref) => BoardRepository(ref.read(dioProvider)));

final class BoardRepository extends Repository {
  BoardRepository(super.dio);

  Future<Board?> getPetitionBoard({
    String? keyword,
    required int page,
    int? bodySize,
    required int size,
    required PetitionStatus status,
  }) async {
    final result = await get(
      path : '/post/petition',
      queryParameter: {
        'keyword': keyword,
        'page': page,
        'size': size,
        'bodySize': bodySize,
        'status': status.value,
        'sort' : 'createdAt,desc',
      },
      allowDuplicateRequest: false,
    );
    return Board.fromJson(result.data);
  }

  Future<Petition?> getPetitionPost({
    required int id,
  }) async {
    final result = await get(
      path : '/post/petition/$id',
      allowDuplicateRequest: false,
    );
    return Petition.fromJson(result.data);
  }

  Future<bool> agreePetitionPost({
    required int id,
  }) async{
    final result = await post(
      path : '/post/petition/agree/$id',
    );
    return result.statusCode == 200;
  }

  Future<bool> reportPetitionPost({
    required int id,
    required String categoryName,
  }) async{
    final result = await post(
      path : '/report/$id',
      queryParameter: {
        'categoryName' : categoryName,
      },
    );
    return result.statusCode == 200;
  }

}
