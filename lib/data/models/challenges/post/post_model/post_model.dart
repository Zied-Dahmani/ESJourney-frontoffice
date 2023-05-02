

import 'package:freezed_annotation/freezed_annotation.dart';

import '../post_item_model/post_item_model.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';
@freezed
class Post with _$Post {
  const factory Post({
    required String username,
    required String avatar,
    required List<PostItem> posts,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}



