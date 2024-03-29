import 'package:esjourney/data/models/club/application/application_state_enum.dart';
import 'package:esjourney/data/models/club/club/club_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
part 'application_model.freezed.dart';
part 'application_model.g.dart';

@freezed
class Application with _$Application {
  const Application._();
  const factory Application({
    required dynamic id,
    required dynamic userId,
    required ApplicationState state,
    required Club club,
    required DateTime dateTime,
    required String resume,
    required String phoneNumber,
    required String birthDate,
    required String studyLevel,
    required String speciality,
    required List<String> answers,
    required String linkedInLink
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) => _$ApplicationFromJson(json);

  String convertDate() => DateFormat('MMM d, h:mm a').format(dateTime);

}