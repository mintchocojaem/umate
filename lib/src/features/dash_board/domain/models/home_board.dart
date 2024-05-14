import '../../../petition/domain/models/petition_post.dart';
import '../../../timetable/domain/models/schedule.dart';
import 'carousel.dart';

class HomeBoard{
  final List<Carousel> carousels;
  final List<PetitionPost> petitions;
  final List<Schedule> schedules;

  HomeBoard({
    required this.carousels,
    required this.petitions,
    required this.schedules,
  });
}