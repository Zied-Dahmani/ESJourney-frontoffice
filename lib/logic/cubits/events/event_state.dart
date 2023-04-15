import 'package:esjourney/data/models/events/event_model.dart';

abstract class EventState{}

class EventInitial extends EventState{}

class EventLoadInProgress extends EventState{}

class EventSuccess extends EventState{
  final List<Event> events;

  EventSuccess(this.events);
}

class EventIsFailure extends EventState{
  final String error;

  EventIsFailure(this.error);
}