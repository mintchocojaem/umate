class BoardListDTO{
  final String title;
  final String? leadingText;
  final String? leadingImagePath;
  final String? trailingText;

  BoardListDTO({this.leadingText, this.leadingImagePath, required this.title, this.trailingText});
}
