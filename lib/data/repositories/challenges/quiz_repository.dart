import 'package:esjourney/data/models/quiz/quiz_model.dart';
import 'package:esjourney/data/repositories/challenges/quiz_repository_interface.dart';


import '../../providers/challenges/quiz_data_provider.dart';
import '../../providers/challenges/quiz_provider.dart';

class QuizRepository implements IQuizRepository {
  final QuizDataProvider _quizDataProvider = QuizDataProvider();

  @override
  Future<dynamic> getQuiz(String language) async {
    final quizProvider = QuizProvider();
    if (quizProvider.quizzes == null) {
      final result = await _quizDataProvider.getQuiz(language);
      if (result.statusCode == 200) {
        final quizzes = (result.data as List<dynamic>)
            .map((quiz) => Quiz.fromJson(quiz))
            .toList();
        quizProvider.quizzes = quizzes;
        return quizzes;
      } else {
        return null;
      }
    } else {
      return quizProvider.quizzes;
    }
  }
}
