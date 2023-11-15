
sealed class PostReportType{
  final String name;
  final String value;

  const PostReportType._(this.name, this.value);

  const factory PostReportType.profanity() = _Profanity;
  const factory PostReportType.fighting() = _Fighting;
  const factory PostReportType.advertisement() = _Advertisement;
  const factory PostReportType.politics() = _Politics;
  const factory PostReportType.pornography() = _Pornography;
  const factory PostReportType.inappropriate() = _Inappropriate;
  const factory PostReportType.fraud() = _Fraud;

}

class _Profanity extends PostReportType {
  const _Profanity() : super._("PROFANITY", "욕설/비하");
}

class _Fighting extends PostReportType {
  const _Fighting() : super._("FIGHTING", "낚시/놀림/도배");
}

class _Advertisement extends PostReportType {
  const _Advertisement() : super._("ADVERTISEMENT", "광고성 게시글");
}

class _Politics extends PostReportType {
  const _Politics() : super._("POLITICS", "정당, 정치인 비하 및 선거운동");
}

class _Pornography extends PostReportType{
  const _Pornography() : super._("PORNOGRAPHY", "음란물/불건전한 만남 및 대화");
}

class _Inappropriate extends PostReportType{
  const _Inappropriate() : super._("INAPPROPRIATE_CONTENT", "게시판 성격에 부적합");
}

class _Fraud extends PostReportType{
  const _Fraud() : super._("FRAUD", "유출/사칭/사기");
}