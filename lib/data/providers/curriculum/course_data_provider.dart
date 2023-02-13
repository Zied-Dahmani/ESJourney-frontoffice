import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class CourseDataProvider{
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getAllCourses(String token) async {
    dynamic req = await dio.request(
      kgetCourses,
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
}
