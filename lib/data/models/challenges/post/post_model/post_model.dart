

import 'package:freezed_annotation/freezed_annotation.dart';



part 'post_model.freezed.dart';
part 'post_model.g.dart';
@freezed
class Post with _$Post {
  const factory Post({
    required String id,
    required String username,
    required String avatar,
    required String status,
    String? mediaContent,
    required int createdAt,
    required int likes,
    required List<String> likedBy,

  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}



