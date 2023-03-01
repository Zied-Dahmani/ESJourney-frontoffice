import 'package:esjourney/data/models/challenges/codingProblem/coding_problem_model.dart';
import 'package:esjourney/data/models/challenges/codingProblem/topSolutions/top_solutions_model.dart';
import 'package:esjourney/data/providers/challenges/coding_problem_data_provider.dart';
import 'package:esjourney/data/repositories/challenges/coding_problem_repository_interface.dart';

class CodingProblemRepository implements ICodingProblemRepository {
  final CodingProblemDataProvider _codingProblemDataProvider =
      CodingProblemDataProvider();

  @override
  Future<dynamic> getCodingProblem() async {
    final result = await _codingProblemDataProvider.getCodingProblem();

    return result.statusCode == 200
        ? CodingProblem.fromJson(result.data)
        : null;
  }



  @override
  Future <dynamic> getTopSolutions(String problemId) async {

    final result = await _codingProblemDataProvider.getTopSolutions(problemId);
    return result.statusCode == 200
        ? result.data.map((topSolutions) => TopSolutions.fromJson(topSolutions)).toList()
        : null;


  }
}
