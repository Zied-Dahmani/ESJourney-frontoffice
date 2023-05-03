

import 'package:esjourney/data/models/challenges/codingProblem/coding_problem_model.dart';

abstract class CodingProblemState {}

class CodingProblemInitial extends CodingProblemState {



}

class CodingProblemLoadInProgress extends CodingProblemState {}

class CodingProblemSuccess extends CodingProblemState {
  final CodingProblem codingProblems;

  CodingProblemSuccess(this.codingProblems);
}

class CodingProblemIsFailure extends CodingProblemState {
  final String error;

  CodingProblemIsFailure(this.error);
}

