import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/comment/general_comment/provider/general_comment_provider.dart';

class GeneralCommentRepository {
  final GeneralCommentProvider generalCommentProvider;

  GeneralCommentRepository({required this.generalCommentProvider});

  Future<GeneralCommentListModel?> getGeneralComment(String token, int id) async {
    return await generalCommentProvider.getGeneralComment(token, id);
  }
}
