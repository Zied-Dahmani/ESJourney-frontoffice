import 'package:bloc/bloc.dart';

class PollsCubit extends Cubit<List<String>> {
  PollsCubit() : super([]);

  void addPoll(String poll) {
    final newState = List<String>.from(state);
    newState.add(poll);
    emit(newState);
  }
}
