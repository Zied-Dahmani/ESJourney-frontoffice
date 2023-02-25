import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class CodingProblemDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> getCodingProblem() async {
    return await dio.request(
      kgetCodingProblem,
      options: Options(
        method: 'GET',
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
}
