import 'board.dart';

class SearchResult {
  final Board notices;
  final Board coalitions;
  final Board petitions;

  SearchResult({
    required this.notices,
    required this.coalitions,
    required this.petitions,
  });
}
