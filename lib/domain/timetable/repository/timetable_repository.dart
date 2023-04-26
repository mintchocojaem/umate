import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/timetable/model/timetable/timetable_model.dart';
import 'package:danvery/domain/timetable/provider/timetable_provider.dart';

class TimetableRepository {
  final TimetableProvider _timetableProvider;

  TimetableRepository._internal(this._timetableProvider);

  static final TimetableRepository _singleton =
      TimetableRepository._internal(TimetableProvider());

  factory TimetableRepository() => _singleton;

  //get lecture
  Future<ApiResponseDTO> searchLecture(
      String accessToken, String keyword) async {
    return await _timetableProvider.searchLecture(accessToken, keyword);
  }

  //get timetable list
  Future<ApiResponseDTO> getTimetableList(String accessToken) async {
    return await _timetableProvider.getTimetableList(accessToken);
  }

  //get timetable
  Future<ApiResponseDTO> getTimetable(
      String accessToken, int timetableId) async {
    return await _timetableProvider.getTimetable(accessToken, timetableId);
  }

  //add timetable
  Future<ApiResponseDTO> addTimetable(
      String accessToken, TimetableModel timetableModel) async {
    return await _timetableProvider.addTimetable(accessToken, timetableModel);
  }

  //edit timetable
  Future<ApiResponseDTO> editTimetable(
      String accessToken, TimetableModel timetableModel) async {
    return await _timetableProvider.editTimetable(accessToken, timetableModel);
  }

}
