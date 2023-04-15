import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class ClubDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 5000;

  Future<Response> getAllClubs() async {
    return await dio.request(
      kgetAllClubs,
      options: Options(
        method: 'GET',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
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