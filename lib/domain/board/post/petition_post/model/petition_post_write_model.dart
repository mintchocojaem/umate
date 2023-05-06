
import 'package:danvery/domain/board/general_board/model/file_model.dart';

enum PetitionPostTag{
  welfare,
  education,
  environment,
  traffic,
  safety,
}

extension PetitionPostTagExtension on PetitionPostTag {
  String get nameKR => ['학생 복지', '학교 교육', '학교 시설 및 환경', '교통시설', '학생 안전'][index];
  int get id => [44372, 44373, 44374, 44375, 44376][index];
}

class PetitionPostWriteModel{
  String title;
  String body;
  List<int> tagIds;
  List<FileModel> files;

  PetitionPostWriteModel({
    required this.title,
    required this.body,
    required this.tagIds,
    required this.files,
  });

}
