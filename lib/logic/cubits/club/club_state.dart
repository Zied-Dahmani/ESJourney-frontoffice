import 'package:esjourney/data/models/club_model.dart';

abstract class ClubState {}

class ClubLoadInProgress extends ClubState {}

class ClubLoadSuccess extends ClubState {
  final List<Club> clubs;
  ClubLoadSuccess(this.clubs);
}

class ClubLoadFailure extends ClubState {
  final String error;
  ClubLoadFailure(this.error);
}
