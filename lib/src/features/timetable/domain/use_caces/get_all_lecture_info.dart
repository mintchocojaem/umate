import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/timetable_remote_repository.dart';
import '../models/lecture_info.dart';

final getAllLectureInfoProvider = Provider.autoDispose
    .family<Future<List<LectureInfo>>, GetAllLectureInfoParams>(
  (ref, params) => GetAllLectureInfo(
    timetableRemoteRepository: ref.read(timetableRemoteRepositoryProvider),
  )(params),
);

class GetAllLectureInfoParams extends UseCaseParams {
  final String? keyword;
  final CancelToken? cancelToken;

  const GetAllLectureInfoParams({
    this.keyword,
    this.cancelToken,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [keyword, cancelToken];
}

class GetAllLectureInfo
    extends UseCase<List<LectureInfo>, GetAllLectureInfoParams> {
  final TimetableRemoteRepository timetableRemoteRepository;

  GetAllLectureInfo({required this.timetableRemoteRepository});

  @override
  Future<List<LectureInfo>> call(GetAllLectureInfoParams params) async {
    // TODO: implement call
    return await timetableRemoteRepository.getAllLectureInfo(
      keyword: params.keyword,
      cancelToken: params.cancelToken,
    );
  }
}
