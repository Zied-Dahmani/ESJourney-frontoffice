abstract class IEventRepository {

  Future<dynamic> getUserEvents(String token);
  Future<dynamic> getAllEvents();
  Future<dynamic> registerEvent(String token, String eventId);
}
