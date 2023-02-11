abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoadInProgress extends QuizState {}

class QuizSuccess extends QuizState {
  final List<dynamic> quizzes;

  QuizSuccess(this.quizzes);
}

class QuizIsFailure extends QuizState {
  final String error;

  QuizIsFailure(this.error);
}
