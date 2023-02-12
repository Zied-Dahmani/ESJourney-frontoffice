abstract class IUserRepository {
  Future<dynamic> signIn(String? id, String password);
}
