import '../model/bus_model.dart';
import '../provider/bus_provider.dart';

class BusRepository {
  final BusProvider busProvider;

  static final BusRepository _singleton =
      BusRepository._internal(BusProvider());

  BusRepository._internal(this.busProvider);

  factory BusRepository() => _singleton;

  Future<List<BusModel>?> getBusListFromStation(
      {required String stationName}) async {
    return await busProvider.getBusListFromStation(stationName);
  }
}
