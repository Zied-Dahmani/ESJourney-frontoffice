abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoadInProgress extends MessagesState {}

class MessagesLoadingSuccess extends MessagesState {
  final List<dynamic> messages;

  MessagesLoadingSuccess(this.messages);
}

class MessagesIsFailure extends MessagesState {
  final String error;

  MessagesIsFailure(this.error);
}
