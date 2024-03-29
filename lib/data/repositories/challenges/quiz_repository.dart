import 'package:esjourney/data/models/challenges/quiz/quiz_model.dart';
import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/repositories/challenges/quiz_repository_interface.dart';


import '../../providers/challenges/quiz_data_provider.dart';


class QuizRepository implements IQuizRepository {
final QuizDataProvider _quizDataProvider = QuizDataProvider();
@override
Future <dynamic> getQuiz(String language) async {
  final result = await _quizDataProvider.getQuiz(language);
  print("result is $result");
  return result.statusCode == 200
      ? result.data.map((quiz) => Quiz.fromJson(quiz)).toList()
      : null;
}
@override
Future answerQuiz(double coins, String token) async {
  final result = await _quizDataProvider.answerQuiz(  coins,  token);

  return result.statusCode == 200 ? User.fromJson(result.data) : null;
}


}
