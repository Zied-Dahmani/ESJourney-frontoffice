import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class SubmitDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> submit(String problemId , String token , int memory  ) async {
    return await dio.request(
      kSubmission,
      data: {'problemId': problemId,  'memory': memory},
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
