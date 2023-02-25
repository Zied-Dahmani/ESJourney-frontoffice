import 'dart:developer' as developer;

import 'package:esjourney/data/repositories/chat/chat_repository.dart';
import 'package:esjourney/logic/cubits/chat/message/message_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());

  final _chatRepository = ChatRepository();

  Future<void> getChat(String token, String id) async {
    try {
      emit(MessagesLoadInProgress());
      final result = await _chatRepository.getChat(token, id);
      result != null
          ? emit(MessagesLoadingSuccess(result))
          : emit(MessagesIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error chat');
      emit(MessagesIsFailure(kcheckInternetConnection));
    }
  }
}
