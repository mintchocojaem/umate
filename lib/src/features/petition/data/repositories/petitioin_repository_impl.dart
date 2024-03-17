import '../../domain/models/petition_board_model.dart';
import '../../domain/repositories/petition_repository.dart';
import '../data_sources/petition_remote_data_source.dart';

class PetitionRepositoryImpl implements PetitionRepository {
  final PetitionRemoteDataSource petitionRemoteDataSource;

  PetitionRepositoryImpl({required this.petitionRemoteDataSource});

  @override
  Future<PetitionBoardModel> getPetitionBoard({
    String? keyword,
    String? status,
    int? bodySize,
    int? page,
    int? size,
  }) async {
    final response = await petitionRemoteDataSource.getPetitionBoard(
      keyword: keyword,
      status: status,
      bodySize: bodySize,
      page: page,
      size: size,
    );
    return response.mapToModel();
  }
}
