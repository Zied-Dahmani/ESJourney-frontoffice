import 'package:esjourney/data/repositories/challenges/posts/post_repository_interface.dart';

import '../../../models/challenges/posts/post_model.dart';

import 'package:image_picker/image_picker.dart';

import '../../../providers/challenges/posts/posts_data_provider.dart';

class PostRepository implements IPostRepository {
  final PostDataProvider _postDataProvider = PostDataProvider();
  @override
  Future<dynamic> createPost(String status, {XFile? media}) async {
    final result = await _postDataProvider.createPost(status, media: media);

    return result.statusCode == 200
        ? result.data.map((post) => Post.fromJson(post)).toList()
        : null;
  }

  @override
  Future<dynamic> getPosts() async {
    final result = await _postDataProvider.getPosts();
    try {

      return result.statusCode == 200
          ? result.data.map((post) => Post.fromJson(post)).toList()
          : null;
    }
    catch (e) {
      print("errorrr " + e.toString());
    }
  }
  @override
  Future<dynamic> likePost(String postId) async {
    final result = await _postDataProvider.likePost(postId);
    try {

      return result.statusCode == 200
          ? result.data.map((post) => Post.fromJson(post)).toList()
          : null;
    }
    catch (e) {
      print("errorrr " + e.toString());
    }
  }
}