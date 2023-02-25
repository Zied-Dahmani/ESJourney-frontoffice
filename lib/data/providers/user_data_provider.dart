import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class UserDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> signIn(String? id, String password) async {
    return await dio.request(
      ksignIn,
      data: {'username': id, 'email': id, 'password': password},
      options: Options(
        method: 'POST',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  //getuser data
  Future<Response> getUserData(String token) async {
    dynamic req = await dio.request(
      kgetUserData,
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'jwt': token,
        },
        validateStatus: (status) {
          print(status);
          return status! < 500;
        },
      ),
    );
    return req;
  }

}
