import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/notice_post.dart';
import '../../domain/use_cases/get_notice_post.dart';

final noticePostViewModelProvider = AsyncNotifierProvider.autoDispose
    .family<NoticePostViewModel, NoticePost, int>(
  () => NoticePostViewModel(),
);

class NoticePostViewModel
    extends AutoDisposeFamilyAsyncNotifier<NoticePost, int> {
  @override
  FutureOr<NoticePost> build(int arg) {
    // TODO: implement build
    return _fetch();
  }

  Future<NoticePost> _fetch() async {
    return await ref.read(
      getNoticePostProvider(
        GetNoticePostParams(id: arg),
      ),
    );
  }
}
