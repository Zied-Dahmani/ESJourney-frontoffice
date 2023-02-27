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
      data: {'username': id, 'email':id, 'password': password},
      options: Options(
        method: 'POST',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  Future<Response> sendEth(
      String senderAddress, String senderPrivateKey, double amount, String token) async {
     var request = await dio.request(
      ksendEth,
      data: {
        'senderAddress': senderAddress,
        'senderPrivateKey': senderPrivateKey,
        'amount': amount,
      },
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
     print("request: $request");
     return request;
  }
}
