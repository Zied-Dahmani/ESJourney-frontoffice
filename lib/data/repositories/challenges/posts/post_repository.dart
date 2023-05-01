
import 'package:esjourney/data/repositories/challenges/posts/post_repository_interface.dart';
import '../../../models/challenges/post/post_model/post_model.dart';
import '../../../providers/challenges/post_provider.dart';
import 'package:image_picker/image_picker.dart';
class PostRepository implements IPostRepository {
  final PostDataProvider _postDataProvider = PostDataProvider();
  @override
  Future<dynamic> createPost(String status, {XFile? media}) async {
    final result = await _postDataProvider.createPost(status, media: media);
    return result.statusCode == 200
        ? result.data.map((post) => Post.fromJson(post)).toList()
        : null;
  }
}
