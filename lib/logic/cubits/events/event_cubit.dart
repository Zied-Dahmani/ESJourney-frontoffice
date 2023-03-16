import 'dart:developer' as developer;

import 'package:esjourney/data/models/events/event_model.dart';
import 'package:esjourney/data/repositories/events/event_repository.dart';
import 'package:esjourney/logic/cubits/events/event_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../user/user_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  final _eventRepository = EventRepository();
  final _userRepository = UserRepository();

  Future<void> getUserEvents(String token) async {
    try {
      emit(EventLoadInProgress());
      final result = await _eventRepository.getUserEvents(token);
      result != null
          ? emit(EventSuccess(result))
          : emit(EventIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error event');
      emit(EventIsFailure(kcheckInternetConnection));
    }
  }
//getall events
  Future<void> getAllEvents() async {
    try {
      emit(EventLoadInProgress());
      final result = await _eventRepository.getAllEvents();
      result != null
          ? emit(EventSuccess(result))
          : emit(EventIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error event');
      emit(EventIsFailure(kcheckInternetConnection));
    }
  }
  Future<void> registerEvent(String token, String eventId) async {
    try {
      emit(EventLoadInProgress());
      final result = await _eventRepository.registerEvent(token, eventId);
      final userResult = await _userRepository.getUserData(token);
      if(result != null){
        emit(UserLogInSuccess(userResult as User) as EventState);
        emit(EventSuccess(result as List<Event>));
      }else {
        emit(UserIsFailure(kidPasswordIncorrect) as EventState);
        emit(EventIsFailure("error while getting data"));
      }
    } catch (e) {
      developer.log(e.toString(), name: 'error event');
      emit(EventIsFailure(kcheckInternetConnection));
    }
  }
}
