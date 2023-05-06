import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/check_update/provider/check_update_provider.dart';

class CheckUpdateRepository {
  final CheckUpdateProvider checkUpdateProvider;

  static final CheckUpdateRepository _singleton =
  CheckUpdateRepository._internal(CheckUpdateProvider());

  CheckUpdateRepository._internal(this.checkUpdateProvider);

  factory CheckUpdateRepository() => _singleton;

  Future<ApiResponseDTO> checkUpdate() async {
    return await checkUpdateProvider.getUpdate();
  }

}
