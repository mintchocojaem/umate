import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/lecture_info.dart';
import '../repositories/timetable_repository.dart';

class GetAllLectureInfoParams {
  final String? keyword;
  final CancelToken? cancelToken;

  GetAllLectureInfoParams({
    this.keyword,
    this.cancelToken,
  });
}

class GetAllLectureInfoUseCase
    extends UseCase<List<LectureInfo>, GetAllLectureInfoParams> {
  final TimetableRepository timetableRepository;

  GetAllLectureInfoUseCase({required this.timetableRepository});

  @override
  Future<List<LectureInfo>> execute(
      GetAllLectureInfoParams params) async {
    // TODO: implement execute
    return await timetableRepository.getAllLectureInfo(
      keyword: params.keyword,
      cancelToken: params.cancelToken,
    );
  }
}
