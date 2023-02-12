import 'dart:developer' as developer;
import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/repositories/user_repository.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:esjourney/utils/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState>
   // with HydratedMixin
  {
  UserCubit() : super(UserInitial()) {
    //
  }

  /*
  @override
  UserLogInSuccess? fromJson(Map<String, dynamic> json) {
    return UserLogInSuccess.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(UserState state) {
    return UserLogInSuccess().toMap();
  }*/

  final _userRepository = UserRepository();

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
}
