import 'package:danvery/domain/board/general_board/model/file_model.dart';

class GeneralPostWriteModel{
  String title;
  String body;
  List<FileModel> files;

  GeneralPostWriteModel({
    required this.title,
    required this.body,
    required this.files,
  });

}
