import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';


final busRepositoryProvider = Provider<BusRepository>((ref) => BusRepository(ref.read(dioProvider)));

final class BusRepository extends Repository{
  BusRepository(super.dio);

  Future<BusList> getBusList(String stationName) async {
    return await fetch(
          () async {
        final response = await dio.get('/bus?stationName=$stationName');
        return BusList.fromJson(response.data);
      },
    );
  }
}
