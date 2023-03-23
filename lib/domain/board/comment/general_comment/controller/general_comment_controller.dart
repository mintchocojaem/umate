import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/comment/general_comment/repository/general_comment_repository.dart';
import 'package:get/get.dart';

class GeneralCommentController extends GetxController{

  final GeneralCommentRepository generalCommentRepository;
  GeneralCommentController({required this.generalCommentRepository});


  Future<GeneralCommentListModel?> getGeneralComment(String token, int id) async{
    return generalCommentRepository.getGeneralComment(token, id);
  }
}
