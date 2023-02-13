import 'package:esjourney/data/models/quiz/quiz_model.dart';

class QuizProvider {
  List<Quiz>? _quizzes;

  List<Quiz>? get quizzes => _quizzes;

  set quizzes(List<Quiz>? value) {
    _quizzes = value;
  }
}
