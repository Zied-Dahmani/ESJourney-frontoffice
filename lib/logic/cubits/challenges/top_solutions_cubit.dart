import 'dart:developer' as developer;

import 'package:esjourney/data/models/challenges/codingProblem/topSolutions/top_solutions_model.dart';
import 'package:esjourney/data/repositories/challenges/coding_problem_repository.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_state.dart';
import 'package:esjourney/logic/cubits/challenges/top_solutions_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/repositories/challenges/quiz_repository.dart';

class TopSolutionsCubit extends Cubit<TopSolutionsState> {
  TopSolutionsCubit() : super(TopSolutionsInitial()) {
  getTopSolutions("63fa1d3b2089df2a2c4e7bed") ;
  }

  final  _topSolutionsRepository = CodingProblemRepository();

  Future<void> getTopSolutions(String problemId) async {
    try {
      emit(TopSolutionsLoadInProgress());
      final result = await _topSolutionsRepository.getTopSolutions(problemId);
      print("result is $result");
      result != null
          ? emit(TopSolutionsSuccess(result ))
          : emit(TopSolutionsIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error top solutions');
      emit(TopSolutionsIsFailure(kcheckInternetConnection));
    }
  }
}
