import 'dart:developer' as developer;

import 'package:esjourney/logic/cubits/challenges/posts/post_state.dart';
import 'package:esjourney/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/challenges/posts/post_repository.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitial());

  final _postRepository = PostRepository();

  Future<void> createPost(String status, {XFile? media}) async {
    try {
      emit(PostLoadInProgress());
      final result = await _postRepository.createPost(status, media: media);

      result != null
          ? emit(PostIsSuccess(result))
          : emit(PostIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error posts ');
      emit(PostIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> getPosts() async {
    try {
      emit(PostLoadInProgress());
      final result = await _postRepository.getPosts();

      result != null
          ? emit(PostIsSuccess(result))
          : emit(PostIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error posts ');
      emit(PostIsFailure(kcheckInternetConnection));
    }
  }

  Future<void> likePost(String postId) async {
    try {
      emit(PostLoadInProgress());
      final result = await _postRepository.likePost(postId);

      result != null
          ? emit(PostIsSuccess(result))
          : emit(PostIsFailure("error while getting data"));
    } catch (e) {
      developer.log(e.toString(), name: 'error posts ');
      emit(PostIsFailure(kcheckInternetConnection));
    }
  }


}
