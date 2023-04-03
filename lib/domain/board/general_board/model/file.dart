import 'package:image_picker/image_picker.dart';

class FileModel {
  late int? id;
  late String? originalName;
  late String url;

  FileModel({
    id,
    originalName,
    url,
  });

  FileModel.fromJson(Map<String, dynamic> json){
    id = json["id"] as int;
    originalName = json["originalName"] as String;
    url = json["url"] as String;
  }

  FileModel.fromImagePicker(XFile image){
    url = image.path;
  }

}
