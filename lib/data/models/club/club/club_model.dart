import 'package:freezed_annotation/freezed_annotation.dart';
part 'club_model.freezed.dart';
part 'club_model.g.dart';

@freezed
class Club with _$Club {
  const Club._();
  const factory Club({
    required dynamic id,
    required String name,
    required List<String> images,
    required String shortDescription,
    required String fullDescription,
    required List likes,
    required DateTime deadline,
    required List<String> shorts,
  }) = _Club;

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);

}
