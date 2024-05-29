enum PostSortType {
  createdAt('최신순', 'createdAt'),
  //agreeCount,
  viewCount('조회순', 'views');

  final String displayName;
  final String value;

  const PostSortType(this.displayName, this.value);
}

enum PostSortOrder {
  asc,
  desc,
}

class PostSort {
  final PostSortType type;
  final PostSortOrder order;

  PostSort({
    required this.type,
    this.order = PostSortOrder.desc,
  });

  @override
  String toString() {
    return '${type.value},${order.name}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PostSort &&
        other.type == type &&
        other.order == order;
  }

  @override
  int get hashCode {
    return type.hashCode ^ order.hashCode;
  }

}