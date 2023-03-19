import 'package:esjourney/data/models/user_model.dart';
import 'package:esjourney/data/providers/user_data_provider.dart';
import 'package:esjourney/data/repositories/user_repository_interface.dart';
import 'package:esjourney/utils/strings.dart';

class UserRepository implements IUserRepository {
  final UserDataProvider _userDataProvider = UserDataProvider();

  @override
  Future<dynamic> signIn(String? id, String password) async {
    final result = await _userDataProvider.signIn(id, password);
    return result.statusCode == 200 ? User.fromJson(result.data) : null;
  }

  @override
  Future signUp(String? id, String email, String password) async {
    final result = await _userDataProvider.signUp(id, email, password);
    return result.statusCode == 201 ? User.fromJson(result.data) : null;
  }

  @override
  Future addAvatars(
      String token, String twoDAvatar, String threeDAvatar) async {
    final result =
        await _userDataProvider.addAvatars(token, twoDAvatar, threeDAvatar);
    return result.statusCode == 200 ? User.fromJson(result.data) : null;
  }

  @override
  Future<dynamic> getUserData(String token) async {
    final result = await _userDataProvider.getUserData(token);
    return result.statusCode == 200 ? User.fromJson(result.data) : null;
  }

  @override
  Future sendEth(String senderAddress, String senderPrivateKey, double amount,
      String token) async {
    final result = await _userDataProvider.sendEth(
        senderAddress, senderPrivateKey, amount, token);
    return result.statusCode == 200 ? User.fromJson(result.data) : null;
  }

  @override
  Future<dynamic> updatePassword(
      String currentPassword, String newPassword, String token) async {
    final result = await _userDataProvider.updatePassword(
        currentPassword, newPassword, token);
    if (result.statusCode == 201) {
      return User.fromJson(result.data);
    } else if (result.statusCode == 400) {
      return AppStrings.kIncorrectPassword;
    }
  }

  @override
  Future<dynamic> updateUsername(
      String newUsername,String token) async {
    final result = await _userDataProvider.updateUsername(
        newUsername, token);
    if (result.statusCode == 201) {
      return User.fromJson(result.data);
    } else if (result.statusCode == 401) {
      return AppStrings.KusernameAlreadyExist;
    }
  }
}
