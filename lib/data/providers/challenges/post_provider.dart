import 'package:dio/dio.dart';
import 'package:esjourney/logic/cubits/user/user_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../../logic/cubits/user/user_cubit.dart';
import '../../../logic/cubits/user/user_state.dart';

class PostDataProvider {
  final dio = Dio()
    ..options.baseUrl = kbaseUrl
    ..options.connectTimeout = 5000
    ..options.receiveTimeout = 3000;

  Future<Response> createPost(String status, {XFile? media}) async {
    String? token = "";
    UserCubit userCubit = UserCubit();

    final state = userCubit.state;
    if (state is UserLogInSuccess) {
      token = state.user.token;
    }
    FormData formData = FormData.fromMap({
      'status': status,
      'media': media != null ? await MultipartFile.fromFile(media.path) : null,
    });

    return await dio.post(
      kCreatePost,
      data: formData,
      options: Options(
        method: 'POST',
        headers: {
          'Content-Type': 'multipart/form-data',
          'jwt': token,
        },
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
  }
}
