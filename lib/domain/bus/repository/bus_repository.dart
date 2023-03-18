

import '../model/bus_model.dart';
import '../provider/bus_provider.dart';

class BusRepository {
  final BusProvider busProvider;

  BusRepository({required this.busProvider});

  Future<List<BusModel>?> getBusListFromStation(String stationName) async {
    return await busProvider.getBusListFromStation(stationName);
  }

}
