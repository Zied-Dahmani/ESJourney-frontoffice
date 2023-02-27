abstract class IUserRepository {
  Future<dynamic> signIn(String? id, String password);
  Future<dynamic> sendEth(String senderAddress, String senderPrivateKey,double amount, String token);
}
