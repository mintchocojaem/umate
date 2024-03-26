import 'package:flutter/foundation.dart';

import 'petition_status_model.dart';

@immutable
final class PetitionPostModel {
  final int id;
  final String title;
  final String author;
  final String body;
  final String? answer;
  final String createdAt;

  //files
  //images
  final PetitionStatusModel status;
  final String expiresAt;
  final int agreeCount;

  //statistics
  final bool agree;
  final bool mine;
  final bool blinded;

  const PetitionPostModel({
    required this.id,
    required this.title,
    required this.author,
    required this.body,
    required this.answer,
    required this.createdAt,
    required this.status,
    required this.expiresAt,
    required this.agreeCount,
    required this.agree,
    required this.mine,
    required this.blinded,
  });
}
