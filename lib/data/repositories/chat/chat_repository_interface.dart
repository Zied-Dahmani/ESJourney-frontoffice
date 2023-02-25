abstract class IChatRepository {
  Future<dynamic> getAllUsers(String token);

  Future<dynamic> getChat(String token, String id);
}
