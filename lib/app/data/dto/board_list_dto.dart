import 'package:flutter/cupertino.dart';

class BoardListDTO{
  final String title;
  final String? leadingText;
  final Widget? leadingImage;
  final String? trailingText;

  BoardListDTO({this.leadingText, this.leadingImage, required this.title, this.trailingText});
}
