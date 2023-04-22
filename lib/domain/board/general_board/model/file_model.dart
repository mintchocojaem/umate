import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path_provider/path_provider.dart';

class FileModel {
  int? id;
  String? originalName;
  String url;
  String thumbnailUrl;
  String mimeType;

  FileModel({
    this.id,
    this.originalName,
    required this.url,
    required this.thumbnailUrl,
    required this.mimeType,
  });

  factory FileModel.fromGeneralPostFile(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as int,
      originalName: json['originalName'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      mimeType: json['mimeType'] as String,
    );
  }

  factory FileModel.fromImagePicker(XFile image){
    return FileModel(
      url: image.path,
      thumbnailUrl: image.path,
      mimeType: mime(image.path)!,
    );
  }

}

Future<File> fileFromImageUrl(String url, String fileName) async {
  final response = await Dio().get(
    url,
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  final file = File('${(await getTemporaryDirectory()).path}/$fileName');
  file.writeAsBytesSync(response.data);
  return file;
}
