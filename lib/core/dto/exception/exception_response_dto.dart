import 'package:danvery/core/dto/api_response_dto.dart';

class ExceptionResponseDTO extends ApiResponseDTO {
  ExceptionResponseDTO({
    String? message,
  }) : super(success: false, data: null, message: message ??
      "서버 연결 중 오류가 발생했습니다");
}
