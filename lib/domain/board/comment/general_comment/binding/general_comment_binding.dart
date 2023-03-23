import 'package:danvery/domain/board/comment/general_comment/controller/general_comment_controller.dart';
import 'package:danvery/domain/board/comment/general_comment/provider/general_comment_provider.dart';
import 'package:danvery/domain/board/comment/general_comment/repository/general_comment_repository.dart';
import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

class GeneralCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeneralCommentController>(
      () => GeneralCommentController(
        generalCommentRepository: GeneralCommentRepository(
          generalCommentProvider:
              GeneralCommentProvider(dio: DioInterceptor().dio),
        ),
      ),
    );
  }
}
