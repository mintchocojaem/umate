import 'package:danvery/app/data/model/bus_model.dart';
import 'package:danvery/app/data/provider/bus_provider.dart';

class BusRepository {
  final BusProvider busProvider;

  BusRepository({required this.busProvider});

  Future<List<BusModel>?> getBusListFromStation(String stationName) async {
    return await busProvider.getBusListFromStation(stationName);
  }

}
