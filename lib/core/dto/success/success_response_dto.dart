import 'package:danvery/core/dto/api_response_dto.dart';

class SuccessResponseDTO extends ApiResponseDTO {
  SuccessResponseDTO({dynamic data, String? message})
      : super(success: true, data: data, message: message ?? "OK");
}
