abstract class IUserRepository {
  Future<dynamic> signIn(String? id, String password);
  Future<dynamic> getUserData(String token);
}
