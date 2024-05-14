import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/send_student_id_use_case.dart';
import '../../../user_dependency_injections.dart';
import '../states/find_student_id_state.dart';

class FindStudentIdNotifier extends AutoDisposeNotifier<FindStudentIdState>{

  @override
  FindStudentIdState build() {
    // TODO: implement build
    return const FindStudentIdInitialState();
  }

  Future<void> sendStudentId({required String phoneNumber}) async {
    state = const FindStudentIdLoadingState();

    final result = await ref.read(sendStudentIdUseCaseProvider)(
      SendStudentIdParams(phoneNumber: phoneNumber),
    );

    state = result.fold(
      (success) => const FindStudentIdSuccessState(),
      (failure) => FindStudentIdFailureState(message: failure.message),
    );
  }

}