import 'dart:developer' as developer;

import 'package:esjourney/data/repositories/chat/chat_repository.dart';
import 'package:esjourney/logic/cubits/chat/user/users_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class UsersDataCubit extends Cubit<UsersDataState> {
  UsersDataCubit() : super(UsersDataInitial());

  final _chatRepository = ChatRepository();

  Future<void> getAllUsers(String token) async {
    try {
      emit(UsersDataLoadInProgress());
      final result = await _chatRepository.getAllUsers(token);
      result != null
          ? emit(UsersDataLoadingSuccess(result))
          : emit(UsersDataIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error all users');
      emit(UsersDataIsFailure(kcheckInternetConnection));
    }
  }
}
