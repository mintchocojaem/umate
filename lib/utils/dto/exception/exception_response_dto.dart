import 'package:danvery/utils/dto/api_response_dto.dart';

class ExceptionResponseDTO extends ApiResponseDTO {
  ExceptionResponseDTO({
    String? message,
  }) : super(success: false, data: null, message: message ??
      "알 수 없는 오류가 발생했습니다");
}
