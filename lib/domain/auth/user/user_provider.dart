import 'package:danvery/domain/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) => UserNotifier(ref));

class UserNotifier extends StateNotifier<User?> {
  UserNotifier(this.ref) : super(null);

  final Ref ref;

  Future<void> getUser(String accessToken) async{
    final user = await ref.read(authRepositoryProvider).getUser(accessToken);
    state = user;
  }

}
