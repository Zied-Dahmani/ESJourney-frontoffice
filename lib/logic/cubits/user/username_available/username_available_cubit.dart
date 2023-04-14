import 'dart:developer' as developer;

import 'package:esjourney/logic/cubits/user/username_available/username_available_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repositories/user_repository.dart';



class UsernameAvailableCubit extends Cubit<UsernameAvailableState> {
  UsernameAvailableCubit() : super(UsernameAvailableInitial());

  final _userRepository = UserRepository();

  Future<void> checkUsername( String username ) async {
    try {

      emit(UsernameAvailableLoadInProgress());

      final result = await _userRepository.checkUsername(username);

      result != null
          ? emit(UsernameAvailableSuccess(result ))
          : emit(UsernameAvailableIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error coding problem');
      emit(UsernameAvailableIsFailure("error while getting data"));
    }

  }
}
