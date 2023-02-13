abstract class IUserRepository {
  Future<dynamic> signIn(String? id, String password);
  Future<dynamic> signUp(String? id,String email, String password);
}
