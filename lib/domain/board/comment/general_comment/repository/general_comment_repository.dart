import 'package:danvery/domain/board/comment/general_comment/model/general_comment_list_model.dart';
import 'package:danvery/domain/board/comment/general_comment/provider/general_comment_provider.dart';

class GeneralCommentRepository {

  final GeneralCommentProvider _generalCommentProvider;

  static final GeneralCommentRepository _singleton =
      GeneralCommentRepository._internal(GeneralCommentProvider());

  GeneralCommentRepository._internal(this._generalCommentProvider);

  factory GeneralCommentRepository()=> _singleton;

  Future<GeneralCommentListModel?> getGeneralComment(String token, int id) async {
    return await _generalCommentProvider.getGeneralComment(token, id);
  }
}
