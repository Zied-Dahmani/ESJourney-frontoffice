import 'package:dio/dio.dart';
import 'package:esjourney/utils/constants.dart';

class ClubDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 10000
    ..options.receiveTimeout = 10000;

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

  Future<Response> apply(String token, String clubId, String? filePath, String fileName,String phoneNumber,String birthDate,String studyLevel,String speciality,List answers, String linkedInLink) async {
    final formData = FormData.fromMap({
      'clubId': clubId,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate,
      'studyLevel': studyLevel,
      'speciality': speciality,
      'answers': answers,
      'linkedInLink': linkedInLink,
      'pdf': await MultipartFile.fromFile(filePath!, filename: fileName)
    });
    return await dio.request(
      kapply,
      data: formData,
      options: Options(
        method: 'POST',
        headers: {
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }

  Future<Response> bookEvent(String token, String clubId, int ticketIndex) async {
    return await dio.request(
      kbookEvent,
      data: {"clubId":clubId,"ticketIndex":ticketIndex},
      options: Options(
        method: 'POST',
        headers: {
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }


}
