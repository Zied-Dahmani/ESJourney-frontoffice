import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class CourseDataProvider{
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getAllCourses() async {
    return await dio.request(
      kgetCourses,
      options: Options(
        method: 'GET',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
}
