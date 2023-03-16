import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class QuizDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getQuiz(String language) async {
  return await dio.request(
      kgetQuiz,
      queryParameters: {
        'language': language,
      },
      options: Options(
        method: 'GET',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

  }
}
