import 'package:esjourney/data/models/events/event_model.dart';
import '../../providers/events/event_data_provider.dart';
import '../../providers/events/event_provider.dart';
import 'event_repository_interface.dart';

class EventRepository implements IEventRepository {
  final EventDataProvider _eventDataProvider = EventDataProvider();

  @override
  Future<dynamic> getUserEvents(String token) async {
    final eventProvider = EventProvider();
    if(eventProvider.events == null){
      final result = await _eventDataProvider.getUserEvents(token);
      if (result.statusCode == 200) {
        final events = (result.data as List<dynamic>)
            .map((event) => Event.fromJson(event))
            .toList();
        eventProvider.events = events;
        return events;
      } else {
        return null;
      }
    }else{
      return eventProvider.events;
    }
  }
  @override
  Future<dynamic> getAllEvents() async {
    final eventProvider = EventProvider();
    if(eventProvider.events == null){
      final result = await _eventDataProvider.getAllEvents();
      if (result.statusCode == 200) {
        print('yess ${result.data}');
        final events = (result.data as List<dynamic>)
            .map((event) => Event.fromJson(event))
            .toList();
        eventProvider.events = events;
        print('here success');
        return events;
      } else {
        print('here problem');
        return null;
      }
    }else{
      return eventProvider.events;
    }
  }
}
