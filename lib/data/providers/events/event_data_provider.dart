import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';


class EventDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getAllEvents() async {
    dynamic req = await dio.request(
      kgetEvents,
      options: Options(
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
        },
        validateStatus: (status) {
          print(status);
          return status! < 500;
        },
      ),
    );
    return req;
  }
  //get user events
  Future<Response> getUserEvents(String token) async {
    dynamic req = await dio.request(
      kgetUserEvent,
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