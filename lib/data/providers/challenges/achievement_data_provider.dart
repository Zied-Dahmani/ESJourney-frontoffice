import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class AchievementDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> addAchievement(String token, String name) async {
    return await dio.post(
      kAddAchievement,
      data: {
        'name': name,
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
