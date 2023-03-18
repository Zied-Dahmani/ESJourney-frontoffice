import 'dart:developer' as developer;

import 'package:esjourney/data/models/challenges/codingProblem/coding_problem_model.dart';
import 'package:esjourney/data/repositories/challenges/coding_problem_repository.dart';
import 'package:esjourney/logic/cubits/challenges/coding_problem_state.dart';
import 'package:esjourney/logic/cubits/challenges/quiz_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/repositories/challenges/quiz_repository.dart';

class CodingProblemCubit extends Cubit<CodingProblemState> {
  CodingProblemCubit() : super(CodingProblemInitial()) {
    getCodingProblem();
  }

  final _codingProblemRespository = CodingProblemRepository();

  Future<void> getCodingProblem() async {
    try {

      emit(CodingProblemLoadInProgress());
      final result = await _codingProblemRespository.getCodingProblem();

      result != null
          ? emit(CodingProblemSuccess(result ))
          : emit(CodingProblemIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error coding problem');
      emit(CodingProblemIsFailure(kcheckInternetConnection));
    }

  }
}
