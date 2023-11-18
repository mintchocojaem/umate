import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final timetableRepositoryProvider = Provider<TimetableRepository>(
    (ref) => TimetableRepository(ref.read(dioProvider)));

final class TimetableRepository extends Repository {
  TimetableRepository(super.dio);

  Future<List<Timetable>> getTimetableInfo() async {
    final response = await dio.get('/timetable');
    return (response.data as List)
        .map((e) => Timetable.fromJson(e))
        .toList();
  }

  Future<Timetable> getTimetable(int id) async {
    final response = await dio.get('/timetable/$id');
    return Timetable.fromJson(response.data);
  }

}
