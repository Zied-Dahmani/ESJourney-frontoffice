import 'dart:developer' as developer;
import 'package:esjourney/data/repositories/user_repository.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial()) {
   //
  }

  final _userRepository = UserRepository();

  Future<void> signIn(String? id,String password) async {
    try {
      final result = await _userRepository.signIn(id,password);
      result != null
          ? emit(UserLogInSuccess(result))
          : emit(UserIsFailure(kbadRequest));
    } catch (e) {
      developer.log(e.toString(), name: 'Catch sign in');
      emit(UserIsFailure(kcheckInternetConnection));
    }
  }

}