import 'package:esjourney/data/models/application_state_enum.dart';
import 'package:esjourney/data/models/club_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'application_model.freezed.dart';
part 'application_model.g.dart';

@freezed
class Application with _$Application {
  const Application._();
  const factory Application({
    required dynamic id,
    required dynamic userId,
    required ApplicationState state,
    required Club club
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) => _$ApplicationFromJson(json);

}