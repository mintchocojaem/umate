import '../../../../core/utils/use_case.dart';
import '../models/petition_post.dart';
import '../models/post_report_type.dart';
import '../repositories/petition_repository.dart';

class ReportPostParams {
  final int id;
  final PostReportType reportType;

  ReportPostParams({
    required this.id,
    required this.reportType,
  });
}

class ReportPostUseCase extends UseCase<bool, ReportPostParams> {
  final PetitionRepository petitionRepository;

  ReportPostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<bool> execute(ReportPostParams params) async {
    return await petitionRepository.reportPost(
      id: params.id,
      type: params.reportType,
    );
  }
}
