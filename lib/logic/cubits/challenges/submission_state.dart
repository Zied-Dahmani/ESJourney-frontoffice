import 'package:esjourney/data/models/challenges/submission/submission_model.dart';

abstract class SubmissionState {}

class SubmissionInitial extends SubmissionState {}

class SubmissionLoadInProgress extends SubmissionState {}

class SubmissionSuccess extends SubmissionState {
  final Submission submission;

  SubmissionSuccess(this.submission);
}

class SubmissionIsFailure extends SubmissionState {
  final String error;

  SubmissionIsFailure(this.error);
}
