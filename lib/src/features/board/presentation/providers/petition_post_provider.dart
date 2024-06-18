import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/petition_post.dart';
import '../../domain/use_cases/get_petition_post.dart';

final petitionPostProvider = AsyncNotifierProvider.autoDispose
    .family<PetitionPostNotifier, PetitionPost, int>(
  () => PetitionPostNotifier(),
);

class PetitionPostNotifier
    extends AutoDisposeFamilyAsyncNotifier<PetitionPost, int> {
  @override
  FutureOr<PetitionPost> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<PetitionPost> _fetch() async {
    return await ref.read(
      getPetitionPostProvider(
        GetPetitionPostParams(id: arg),
      ),
    );
  }
}
