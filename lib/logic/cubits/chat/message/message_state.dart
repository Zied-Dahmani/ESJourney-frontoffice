import 'package:esjourney/chatest/message_model.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoadInProgress extends MessagesState {}

class MessagesSuccess extends MessagesState {
  final List<dynamic> messages;

  MessagesSuccess(this.messages);
}

class MessagesIsFailure extends MessagesState {
  final String error;

  MessagesIsFailure(this.error);
}
