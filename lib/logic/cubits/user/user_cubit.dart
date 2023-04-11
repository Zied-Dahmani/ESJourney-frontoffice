import 'dart:developer' as developer;
import 'package:esjourney/data/repositories/user_repository.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/firebase_cloud_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../data/repositories/challenges/quiz_repository.dart';
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

  Future<void> refreshUserData(String token) async {
    try {
      final result = await _userRepository.getUserData(token);
      if (result != null) {
        emit(UserLogInSuccess(result));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'error user');
    }
  }

  Future<void> signIn(String? id, String password) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.signIn(id, password);
      if (result != null) {
        emit(UserLogInSuccess(result));
      } else {
        emit(UserIsFailure(kidPasswordIncorrect));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'error user');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> signUp(String? id, String email, String password) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.signUp(id, email, password);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure("error in sign up"));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> addAvatars(
      String token, String twoDAvatar, String threeDAvatar) async {
    try {
      emit(UserLoadInProgress());
      final result =
          await _userRepository.addAvatars(token, twoDAvatar, threeDAvatar);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure("error in sign up"));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> sendEth(String? walletAddress, String privateKey, double amount,
      String token) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.sendEth(
          walletAddress!, privateKey, amount, token);
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

  updateDeviceToken(String token) {
    FirebaseMessaging.instance.getToken().then((deviceToken) async {
      await _userRepository.updateDeviceToken(token, deviceToken!);
    });
  }

  Future<void> sendNotif(title, body, deviceToken) async {
    await FirebaseCloudMessaging.sendTo(
      title: title,
      body: body,
      fcmToken: deviceToken,
    );
  }

  Future<bool> bookEventWithETH(String? walletAddress, String privateKey,
      double amount, String token) async {
    try {
      final result = await _userRepository.sendEth(
          walletAddress!, privateKey, amount, token);
      return result != null ? true : false;
    } catch (e) {
      developer.log(e.toString(), name: 'Catch send eth');
      return false;
    }
  }
}
