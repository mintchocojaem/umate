import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/timetable/provider/timetable_provider.dart';

class TimetableRepository{
  final TimetableProvider _timetableProvider;

  TimetableRepository._internal(this._timetableProvider);

  static final TimetableRepository _singleton = TimetableRepository._internal(TimetableProvider());

  factory TimetableRepository() => _singleton;

  //get lecture
  Future<ApiResponseDTO> searchLecture(String accessToken,String keyword) async {
    return await _timetableProvider.searchLecture(accessToken, keyword);
  }
}
