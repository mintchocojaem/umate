import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/petition_remote_repository.dart';

final writePetitionPostProvider =
    Provider.autoDispose.family<Future<bool>, WritePetitionPostParams>(
  (ref, params) => WritePetitionPost(
    petitionRemoteRepository: ref.watch(petitionRemoteRepositoryProvider),
  )(params),
);

class WritePetitionPostParams extends UseCaseParams {
  final String title;
  final String body;
  final List<String> images;
  final List<String> files;

  const WritePetitionPostParams({
    required this.title,
    required this.body,
    required this.images,
    required this.files,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [title, body, images, files];
}

class WritePetitionPost extends UseCase<bool, WritePetitionPostParams> {
  final PetitionRemoteRepository petitionRemoteRepository;

  WritePetitionPost({
    required this.petitionRemoteRepository,
  });

  @override
  Future<bool> call(WritePetitionPostParams params) async {
    // TODO: implement call
    return await petitionRemoteRepository.writePost(
      title: params.title,
      body: params.body,
      images: params.images,
      files: params.files,
    );
  }
}
