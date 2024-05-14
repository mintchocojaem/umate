import '../../../../core/utils/use_case.dart';
import '../repositories/petition_repository.dart';

class WritePetitionPostParams {
  final String title;
  final String body;
  final List<String> images;
  final List<String> files;

  WritePetitionPostParams({
    required this.title,
    required this.body,
    required this.images,
    required this.files,
  });
}

class WritePetitionPostUseCase extends UseCase<bool, WritePetitionPostParams> {
  final PetitionRepository petitionRepository;

  WritePetitionPostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<bool> execute(WritePetitionPostParams params) async {
    return await petitionRepository.writePetition(
      title: params.title,
      body: params.body,
      images: params.images,
      files: params.files,
    );
  }
}
