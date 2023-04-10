import 'package:freezed_annotation/freezed_annotation.dart';

part 'poll_model.freezed.dart';
part 'poll_model.g.dart';

@freezed
class Poll with _$Poll {
  const factory Poll({
    required String id,
    required String question,
    required List<String> options,
    required Map<String, int> votes, // Store the votes for each option using a map
    required String hostId, // You can add this field if you want to store the host ID of the poll
  }) = _Poll;

  factory Poll.fromJson(Map<String, dynamic> json) => _$PollFromJson(json);
}
