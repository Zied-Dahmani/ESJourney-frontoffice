import 'dart:developer' as developer;

import 'package:esjourney/data/repositories/events/event_repository.dart';
import 'package:esjourney/logic/cubits/events/event_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventInitial());

  final _eventRepository = EventRepository();

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
  Future<void> getAllEvents() async {
    try {
      emit(EventLoadInProgress());
      final result = await _eventRepository.getAllEvents();
      print('result $result');
      if(result != null){
        print('here success');
          emit(EventSuccess(result));

      }else{
        print('here problem');
           emit(EventIsFailure("error while getting data"));

      }
    } catch (e) {
      print('here problem');
      developer.log(e.toString(), name: 'error event');
      emit(EventIsFailure(kcheckInternetConnection));
    }
  }
  Future<void> registerEvent(String token, String eventId) async {
    try {
      emit(EventLoadInProgress());
      final result = await _eventRepository.registerEvent(token, eventId);
      result != null
          ? emit(EventSuccess(result))
          : emit(EventIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error event');
      emit(EventIsFailure(kcheckInternetConnection));
    }
  }
}
