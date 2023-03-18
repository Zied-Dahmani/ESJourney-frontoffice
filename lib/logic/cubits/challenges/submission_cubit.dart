import 'dart:developer' as developer;

import 'package:esjourney/data/repositories/challenges/submission_repository.dart';
import 'package:esjourney/logic/cubits/challenges/submission_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class SubmissionCubit extends Cubit<SubmissionState> {
  SubmissionCubit() : super(SubmissionInitial()) ;

  final _submissionRepository = SubmitRepository();

  Future<void> submit(String problemId , String token , int memory) async {
    try {
      emit(SubmissionLoadInProgress());
      final result = await _submissionRepository.submit(problemId, token, memory);
      result != null
          ? emit(SubmissionSuccess(result))
          : emit(SubmissionIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error quiz');
      emit(SubmissionIsFailure(kcheckInternetConnection));
    }
  }
}
