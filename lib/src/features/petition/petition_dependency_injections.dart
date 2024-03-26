import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../init_dependency_injections.dart';
import 'data/data_sources/petition_remote_data_source.dart';

final petitionRemoteDataSourceProvider =
    Provider.autoDispose<PetitionRemoteDataSource>((ref) {
  return PetitionRemoteDataSource(
      networkClientService: ref.read(networkClientServiceProvider));
});
