abstract class IUserRepository {
  Future<dynamic> signIn(String? id, String password);
  Future<dynamic> getUserData(String token);
  Future<dynamic> signUp(String? id,String email, String password);
  Future<dynamic> addAvatars(String token,String twoDAvatar, String threeDAvatar);
  Future<dynamic> sendEth(String senderAddress, String senderPrivateKey, double amount, String token);
   Future<dynamic> updatePassword( String currentPassword, String newPassword,String token);
}
