import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';


final busRepositoryProvider = Provider<BusRepository>((ref) => BusRepository(ref.read(dioProvider)));

final class BusRepository extends Repository{
  BusRepository(super.dio);

  Future<BusList?> getBusList(String stationName) async {
    final result = await get(
      path: '/bus',
      queryParameter: {
        'stationName': stationName,
      },
    );
    return BusList.fromJson(result.data);
  }
}
