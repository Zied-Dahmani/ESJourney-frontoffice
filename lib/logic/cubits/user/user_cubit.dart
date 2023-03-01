import 'dart:developer' as developer;
import 'package:esjourney/data/repositories/challenges/quiz_repository.dart';
import 'package:esjourney/data/repositories/user_repository.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> with HydratedMixin {
  UserCubit() : super(UserInitial()) {
    //
  }

  @override
  UserLogInSuccess? fromJson(Map<String, dynamic> json) {
    return UserLogInSuccess.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state is UserLogInSuccess
        ? UserLogInSuccess(state.user).toMap()
        : null;
  }

  final _userRepository = UserRepository();
  final _quizRepository = QuizRepository();

  Future<void> signIn(String? id, String password) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.signIn(id, password);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure(kidPasswordIncorrect));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }
  Future<void> sendEth(String? walletAddress, String privateKey,double amount, String token) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.sendEth( walletAddress!, privateKey,  amount,token);
          result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure(kerrorSendingEth));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch send eth');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> answerQuiz(double coins, String token) async {
    try {
      emit(UserLoadInProgress());
      final result = await _quizRepository.answerQuiz(coins, token);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure(kerrorSendingEth));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch answer quiz');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }
}