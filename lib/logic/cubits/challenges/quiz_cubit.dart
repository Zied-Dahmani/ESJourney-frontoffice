import 'dart:developer' as developer;

import 'package:esjourney/logic/cubits/challenges/quiz_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/repositories/challenges/quiz_repository.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial()) {
    getQuiz("c");
  }

  final _quizRepository = QuizRepository();

  Future<void> getQuiz(String language) async {
    try {
      emit(QuizLoadInProgress());
      final result = await _quizRepository.getQuiz(language);
      result != null
          ? emit(QuizSuccess(result))
          : emit(QuizIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error quiz');
      emit(QuizIsFailure(kcheckInternetConnection));
    }
  }
}
