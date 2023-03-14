import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class CourseDataProvider{
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 5000;

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

  Future<Response> getAllClubEvents() async {
    return await dio.request(
      kgetAllClubEvents,
      options: Options(
        method: 'GET',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  Future<Response> getAllApplications() async {
    return await dio.request(
      kgetAllApplications,
      options: Options(
        method: 'GET',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
}
