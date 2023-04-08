import 'dart:async';

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
          return status! < 500;
        }
      ),
    );
    return req;
  }

  Future<Response> signUp(String? id,String email, String password) async {
    return await dio.request(
      ksignUp,
      data: {'username': id, 'email':email, 'password': password},
      options: Options(
        method: 'POST',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  Future<Response> addAvatars(String token,String twoDAvatar, String threeDAvatar) async {
    return await dio.request(
      kaddAvatar,
      data: { 'twoDAvatar':twoDAvatar, 'threeDAvatar': threeDAvatar},
      options: Options(
        method: 'POST',
        headers: {
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
  Future<Response> sendEth(
      String senderAddress, String senderPrivateKey, double amount, String token) async {
    return await dio.request(
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

  }
}




