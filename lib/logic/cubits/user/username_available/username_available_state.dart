

import 'package:esjourney/data/models/challenges/codingProblem/coding_problem_model.dart';

abstract class UsernameAvailableState {}

class UsernameAvailableInitial extends UsernameAvailableState {



}

class UsernameAvailableLoadInProgress extends UsernameAvailableState {}

class UsernameAvailableSuccess extends UsernameAvailableState {
  final bool isAvailable;

  UsernameAvailableSuccess(this.isAvailable);

}


class UsernameAvailableIsFailure extends UsernameAvailableState {
  final String error;

  UsernameAvailableIsFailure(this.error);
}
