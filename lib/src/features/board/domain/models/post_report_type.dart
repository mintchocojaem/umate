enum PostReportType {
  profanity("PROFANITY", "욕설/비하"),
  fishing("FISHING", "낚시/놀림/도배"),
  advertisement("ADVERTISEMENT", "광고/홍보 게시물"),
  politics("POLITICS", "정치인/종교 비하"),
  pornography("PORNOGRAPHY", "음란물/성적인 내용"),
  fraud("FRAUD", "사기/유출/사칭"),
  inappropriateContent("INAPPROPRIATE_CONTENT", "부적절한 내용");

  final String value;
  final String name;

  const PostReportType(this.value, this.name);
}