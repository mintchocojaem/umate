import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final boardRepositoryProvider =
    Provider<BoardRepository>((ref) => BoardRepository(ref.read(dioProvider)));

final class BoardRepository extends Repository {
  BoardRepository(super.dio);

  Future<Board> getPetitionBoard({
    String? keyword,
    required int page,
    int? bodySize,
    required int size,
    required PetitionStatus status,
  }) async {
    final result = await get(
      path: '/post/petition',
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
        'bodySize': bodySize,
        'status': status.value,
        'sort': 'createdAt,desc',
      },
      allowDuplicateRequest: false,
    );
    return Board.fromJson(result!.data);
  }

  Future<bool> writePetitionPost(
      {required String title,
      required String body,
      XFile? image,
      FilePickerResult? file}) async {

    String getMimeType (String? path) {
      final mimeType = mime(path);
      return mimeType ?? 'application/octet-stream';
    }

    final result = await post(
      path: '/post/petition',
      data: FormData.fromMap(
        {
          'title': title,
          'body': body,
          if (image != null)
            'images': await MultipartFile.fromFile(
              image.path,
              contentType: MediaType(
                getMimeType(image.path).split('/')[0],
                getMimeType(image.path).split('/')[1],
              ),
            ),
          if (file != null)
            'files': await MultipartFile.fromFile(
              file.files.single.path!,
              filename: file.files.single.name,
              contentType: MediaType(
                getMimeType(file.files.single.name).split('/')[0],
                getMimeType(file.files.single.name).split('/')[1],
              ),
            ),
        },
      ),
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    return result!.statusCode == 200;
  }

  Future<Petition> getPetitionPost({
    required int id,
  }) async {
    final result = await get(
      path: '/post/petition/$id',
      allowDuplicateRequest: false,
    );
    return Petition.fromJson(result!.data);
  }

  Future<bool> agreePetitionPost({
    required int id,
  }) async {
    final result = await post(
      path: '/post/petition/agree/$id',
    );
    return result!.statusCode == 200;
  }

  Future<bool> reportPetitionPost({
    required int id,
    required String categoryName,
  }) async {
    final result = await post(
      path: '/report/$id',
      queryParameters: {
        'categoryName': categoryName,
      },
    );
    return result!.statusCode == 200;
  }
}
