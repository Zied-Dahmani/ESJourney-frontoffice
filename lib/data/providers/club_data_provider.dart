import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class ClubDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  /*Future<Response> getClubs() async {
    return await dio.request(
      kgetUpcomingEvents,
      options: Options(method: 'GET'),
    );
  }*/

}
