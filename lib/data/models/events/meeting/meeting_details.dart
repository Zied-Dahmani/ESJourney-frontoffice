import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_details.freezed.dart';
part 'meeting_details.g.dart';

@freezed
class MeetingDetail with _$MeetingDetail {
  const factory MeetingDetail({
    String? id,
    String? hostId,
    String? hostName,
  }) = _MeetingDetail;

  factory MeetingDetail.fromJson(Map<String, dynamic> json) =>
      _$MeetingDetailFromJson(json);
}
