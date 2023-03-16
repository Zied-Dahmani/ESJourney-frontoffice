import 'dart:developer' as developer;
import 'package:esjourney/data/models/events/event_model.dart';
import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/repositories/user_repository.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'user_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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

  Future<void> signUp(String? id,String email, String password) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.signUp(id,email, password);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure("error in sign up"));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> addAvatars(String token,String twoDAvatar, String threeDAvatar) async {
    try {
      emit(UserLoadInProgress());
      final result = await _userRepository.addAvatars(token,twoDAvatar, threeDAvatar);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure("error in sign up"));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign up');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }
}
