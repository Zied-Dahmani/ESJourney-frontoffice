import 'package:image_picker/image_picker.dart';

abstract class IPostRepository {
  Future<dynamic> createPost(String status, {XFile? media}) ;
}