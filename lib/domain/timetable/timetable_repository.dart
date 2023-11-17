import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>(
    (ref) => TimetableRepository(ref.read(dioProvider)));

final class TimetableRepository extends Repository {
  TimetableRepository(super.dio);

  Future<List<Timetable>?> getTimetableInfo() async {
    final response = await dio.get('/timetable');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => Timetable.fromJson(e))
          .toList();
    }
    return null;
  }

  Future<Timetable?> getTimetable(int id) async {
    final response = await dio.get('/timetable/$id');
    if (response.statusCode == 200) {
      return Timetable.fromJson(response.data);
    }
    return null;
  }

}
