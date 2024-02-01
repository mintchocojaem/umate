part of 'petition_board_screen.dart';

final petitionBoardScreenProvider = NotifierProvider.autoDispose<
    PetitionBoardScreenNotifier, PetitionBoardScreenState>(
  () => PetitionBoardScreenNotifier(),
);

class PetitionBoardScreenState {}

class PetitionBoardScreenNotifier
    extends AutoDisposeNotifier<PetitionBoardScreenState>
    with PetitionDateFormat {
  @override
  PetitionBoardScreenState build() {
    // TODO: implement build
    return PetitionBoardScreenState();
  }

  String petitionRemainingDate(String expiresAt) {
    final date = DateTime.parse(expiresAt);
    final now = DateTime.now();
    return now.isBefore(date) ? 'D-${date.difference(now).inDays}' : '마감';
  }

  String petitionDuration(String createdAt, String expiresAt) {
    final createdDate = dateFormatCompact(createdAt);
    final expiresDate = dateFormatCompact(expiresAt);
    return '$createdDate ~ $expiresDate';
  }

  String getPetitionStatus(String status){
    return PetitionStatus.values.firstWhere((element) => element.value == status).display;
  }

}
