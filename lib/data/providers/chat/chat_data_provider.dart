import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class ChatDataProvider{
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getAllUsers(String token) async {
    dynamic req = await dio.request(
      kgetAllUsers,
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    return req;
  }

  Future<Response> getChat(String token,String id) async {
    dynamic req = await dio.request(
      kgetChat,
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
      queryParameters: {
        'from': id,
      },
    );
    return req;
  }
}
