
import 'package:esjourney/data/models/challenges/codingProblem/topSolutions/top_solutions_model.dart';

abstract class ICodingProblemRepository {
  Future<dynamic> getCodingProblem();
  Future<dynamic> getTopSolutions(String problemId);
}
