abstract class IEventRepository {

  Future<dynamic> getUserEvents(String token);
  Future<dynamic> getAllEvents();
}
