abstract class IQuizRepository {
  Future<dynamic> getQuiz(String language);
  Future<dynamic> answerQuiz(double coins, String token);
}
