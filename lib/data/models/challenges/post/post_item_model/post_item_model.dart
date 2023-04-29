

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_item_model.freezed.dart';
part 'post_item_model.g.dart';
@freezed
class PostItem with _$PostItem {
  const factory PostItem({
    required String status,
    String? mediaContent,
    required int createdAt,
  }) = _PostItem;

  factory PostItem.fromJson(Map<String, dynamic> json) => _$PostItemFromJson(json);
}



