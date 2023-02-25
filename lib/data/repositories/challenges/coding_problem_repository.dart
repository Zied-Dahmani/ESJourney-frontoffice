


import 'package:esjourney/data/models/challenges/codingProblem/coding_problem_model.dart';
import 'package:esjourney/data/providers/challenges/coding_problem_data_provider.dart';
import 'package:esjourney/data/repositories/challenges/coding_problem_repository_interface.dart';



class CodingProblemRepository implements ICodingProblemRepository{
  final CodingProblemDataProvider _codingProblemDataProvider = CodingProblemDataProvider();

  @override
  Future <dynamic> getCodingProblem () async {

    final result = await _codingProblemDataProvider.getCodingProblem();


    return result.statusCode == 200 ? CodingProblem.fromJson(result.data) : null;


  }


}

