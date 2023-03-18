import 'package:esjourney/data/models/club_event_model.dart';

abstract class ClubEventState {}

class ClubEventLoadInProgress extends ClubEventState {}

class ClubEventLoadSuccess extends ClubEventState {
  final List<ClubEvent> clubEvents;
  ClubEventLoadSuccess(this.clubEvents);
}

class ClubEventLoadFailure extends ClubEventState {
  final String error;
  ClubEventLoadFailure(this.error);
}
